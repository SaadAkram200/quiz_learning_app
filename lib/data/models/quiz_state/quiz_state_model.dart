import 'package:freezed_annotation/freezed_annotation.dart';
import '../question/question_model.dart';
import '../quiz_result/quiz_result_model.dart';

part 'quiz_state_model.freezed.dart';

// Quiz state enumeration
enum QuizStatus {
  initial,
  loading,
  countdown,
  inProgress,
  showingFeedback,
  completed,
  error,
}

@freezed
abstract class QuizStateModel with _$QuizStateModel {
  const QuizStateModel._();

  const factory QuizStateModel({
    @Default(QuizStatus.initial) QuizStatus status,
    @Default(0) int categoryId,
    @Default('') String categoryName,
    @Default([]) List<QuestionModel> questions,
    @Default(0) int currentQuestionIndex,
    @Default(60) int timeRemainingSeconds,
    String? selectedAnswer,
    bool? isCorrect,
    @Default(0) int correctAnswers,
    @Default(3) int countdownValue,
    @Default([]) List<QuestionResultModel> questionResults,
    QuizResultModel? result,
    String? errorMessage,
    DateTime? quizStartTime,
  }) = _QuizStateModel;

  // Get current question
  QuestionModel? get currentQuestion {
    if (questions.isEmpty || currentQuestionIndex >= questions.length) {
      return null;
    }
    return questions[currentQuestionIndex];
  }

  // Get progress percentage
  double get progressPercentage {
    if (questions.isEmpty) return 0;
    return ((currentQuestionIndex + 1) / questions.length) * 100;
  }

  // Get progress text
  String get progressText => '${currentQuestionIndex + 1}/${questions.length}';

  // Check if it's the last question
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  // Get timer progress percentage
  double get timerProgress => timeRemainingSeconds / 60;

  // Create initial state
  factory QuizStateModel.initial() => const QuizStateModel();

  // Create loading state
  factory QuizStateModel.loading(int categoryId, String categoryName) =>
      QuizStateModel(
        status: QuizStatus.loading,
        categoryId: categoryId,
        categoryName: categoryName,
      );

  // Create countdown state
  factory QuizStateModel.countdown({
    required int categoryId,
    required String categoryName,
    required List<QuestionModel> questions,
    int countdownValue = 3,
  }) =>
      QuizStateModel(
        status: QuizStatus.countdown,
        categoryId: categoryId,
        categoryName: categoryName,
        questions: questions,
        countdownValue: countdownValue,
      );

  // Create in progress state
  factory QuizStateModel.inProgress({
    required int categoryId,
    required String categoryName,
    required List<QuestionModel> questions,
    int currentQuestionIndex = 0,
    int timeRemainingSeconds = 60,
    int correctAnswers = 0,
    List<QuestionResultModel> questionResults = const [],
    DateTime? quizStartTime,
  }) =>
      QuizStateModel(
        status: QuizStatus.inProgress,
        categoryId: categoryId,
        categoryName: categoryName,
        questions: questions,
        currentQuestionIndex: currentQuestionIndex,
        timeRemainingSeconds: timeRemainingSeconds,
        correctAnswers: correctAnswers,
        questionResults: questionResults,
        quizStartTime: quizStartTime ?? DateTime.now(),
      );
}
