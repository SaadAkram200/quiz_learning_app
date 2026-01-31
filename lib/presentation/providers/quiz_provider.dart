import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/injection.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/quiz_state/quiz_state_model.dart';
import '../../data/models/quiz_result/quiz_result_model.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/repositories/user_repository.dart';
import 'auth_provider.dart';
import 'user_provider.dart';

// Quiz repository provider
final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return getIt<QuizRepository>();
});

// Quiz state notifier provider
final quizProvider = StateNotifierProvider<QuizNotifier, QuizStateModel>((ref) {
  return QuizNotifier(
    ref.watch(quizRepositoryProvider),
    getIt<UserRepository>(),
    ref,
  );
});

// Quiz state notifier
class QuizNotifier extends StateNotifier<QuizStateModel> {
  final QuizRepository _quizRepository;
  final UserRepository _userRepository;
  final Ref _ref;
  Timer? _countdownTimer;
  Timer? _questionTimer;
  int _questionStartTime = 0;

  QuizNotifier(this._quizRepository, this._userRepository, this._ref)
    : super(QuizStateModel.initial());

  // Start a new quiz for a category
  Future<void> startQuiz(int categoryId, String categoryName) async {
    state = QuizStateModel.loading(categoryId, categoryName);

    try {
      final questions = await _quizRepository.getQuestions(
        categoryId: categoryId,
        amount: AppConstants.questionsPerQuiz,
      );

      if (questions.isEmpty) {
        state = state.copyWith(
          status: QuizStatus.error,
          errorMessage: 'No questions available for this category',
        );
        return;
      }

      // Start countdown
      state = QuizStateModel.countdown(
        categoryId: categoryId,
        categoryName: categoryName,
        questions: questions,
        countdownValue: AppConstants.countdownSeconds,
      );

      _startCountdown();
    } catch (e) {
      state = state.copyWith(
        status: QuizStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // Start countdown animation
  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdownValue <= 1) {
        timer.cancel();
        _startQuestions();
      } else {
        state = state.copyWith(countdownValue: state.countdownValue - 1);
      }
    });
  }

  // Start showing questions
  void _startQuestions() {
    state = QuizStateModel.inProgress(
      categoryId: state.categoryId,
      categoryName: state.categoryName,
      questions: state.questions,
      currentQuestionIndex: 0,
      timeRemainingSeconds: AppConstants.questionTimeSeconds,
      quizStartTime: DateTime.now(),
    );

    _questionStartTime = AppConstants.questionTimeSeconds;
    _startQuestionTimer();
  }

  // Start timer for current question
  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.status != QuizStatus.inProgress) {
        timer.cancel();
        return;
      }

      if (state.timeRemainingSeconds <= 1) {
        timer.cancel();
        _handleTimeOut();
      } else {
        state = state.copyWith(
          timeRemainingSeconds: state.timeRemainingSeconds - 1,
        );
      }
    });
  }

  // Handle when time runs out
  void _handleTimeOut() {
    _submitAnswer(null);
  }

  // Submit an answer
  void submitAnswer(String answer) {
    if (state.status != QuizStatus.inProgress) return;
    _submitAnswer(answer);
  }

  void _submitAnswer(String? answer) {
    _questionTimer?.cancel();

    final currentQuestion = state.currentQuestion;
    if (currentQuestion == null) return;

    final isCorrect = answer != null && currentQuestion.isCorrectAnswer(answer);
    final timeSpent = _questionStartTime - state.timeRemainingSeconds;

    // Record question result
    final questionResult = QuestionResultModel(
      question: currentQuestion.question,
      correctAnswer: currentQuestion.correctAnswer,
      userAnswer: answer,
      isCorrect: isCorrect,
      timeSpentSeconds: timeSpent,
    );

    final newQuestionResults = [...state.questionResults, questionResult];
    final newCorrectAnswers = state.correctAnswers + (isCorrect ? 1 : 0);

    // Show feedback
    state = state.copyWith(
      status: QuizStatus.showingFeedback,
      selectedAnswer: answer,
      isCorrect: isCorrect,
      correctAnswers: newCorrectAnswers,
      questionResults: newQuestionResults,
    );

    // After 1 second, move to next question or complete quiz
    Future.delayed(Duration(milliseconds: AppConstants.feedbackDelayMs), () {
      if (state.isLastQuestion) {
        _completeQuiz();
      } else {
        _moveToNextQuestion();
      }
    });
  }

  // Move to the next question
  void _moveToNextQuestion() {
    state = state.copyWith(
      status: QuizStatus.inProgress,
      currentQuestionIndex: state.currentQuestionIndex + 1,
      timeRemainingSeconds: AppConstants.questionTimeSeconds,
      selectedAnswer: null,
      isCorrect: null,
    );

    _questionStartTime = AppConstants.questionTimeSeconds;
    _startQuestionTimer();
  }

  // Complete the quiz and calculate results
  Future<void> _completeQuiz() async {
    final timeTaken = DateTime.now().difference(
      state.quizStartTime ?? DateTime.now(),
    );

    // Calculate score (10 points per correct answer)
    final scoreEarned = state.correctAnswers * 10;

    final result = QuizResultModel(
      categoryId: state.categoryId,
      categoryName: state.categoryName,
      correctAnswers: state.correctAnswers,
      totalQuestions: state.questions.length,
      scoreEarned: scoreEarned,
      timeTaken: timeTaken,
      questionResults: state.questionResults,
    );

    state = state.copyWith(status: QuizStatus.completed, result: result);

    // Update user score and category progress
    await _updateUserProgress(result);
  }

  // Update user progress after quiz completion
  Future<void> _updateUserProgress(QuizResultModel result) async {
    final currentUser = _ref.read(currentUserProvider);
    if (currentUser == null) return;

    try {
      // Update user score
      final updatedUser = await _userRepository.updateUserScore(
        currentUser.id,
        result.scoreEarned,
      );

      // Update category progress
      await _userRepository.updateCategoryProgress(
        userId: currentUser.id,
        categoryId: result.categoryId,
        correctAnswers: result.correctAnswers,
        totalQuestions: result.totalQuestions,
      );

      // Update auth state with new user data
      await _ref.read(authProvider.notifier).updateUser(updatedUser);

      // Refresh categories
      _ref.invalidate(categoriesProvider);
    } catch (e) {
      print('Failed to update user progress: $e');
    }
  }

  // Reset quiz state
  void resetQuiz() {
    _countdownTimer?.cancel();
    _questionTimer?.cancel();
    state = QuizStateModel.initial();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _questionTimer?.cancel();
    super.dispose();
  }
}
