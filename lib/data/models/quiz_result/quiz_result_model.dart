import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_result_model.freezed.dart';

@freezed
abstract class QuizResultModel with _$QuizResultModel {
  const QuizResultModel._();

  const factory QuizResultModel({
    required int categoryId,
    required String categoryName,
    required int correctAnswers,
    required int totalQuestions,
    required int scoreEarned,
    required Duration timeTaken,
    required List<QuestionResultModel> questionResults,
  }) = _QuizResultModel;

  // Calculate percentage score
  double get percentageScore =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

  // Check if passed (>= 60%)
  bool get isPassed => percentageScore >= 60;

  // Get grade based on percentage
  String get grade {
    if (percentageScore >= 90) return 'A';
    if (percentageScore >= 80) return 'B';
    if (percentageScore >= 70) return 'C';
    if (percentageScore >= 60) return 'D';
    return 'F';
  }

  // Get formatted time
  String get formattedTime {
    final minutes = timeTaken.inMinutes;
    final seconds = timeTaken.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

@freezed
abstract class QuestionResultModel with _$QuestionResultModel {
  const factory QuestionResultModel({
    required String question,
    required String correctAnswer,
    String? userAnswer,
    required bool isCorrect,
    required int timeSpentSeconds,
  }) = _QuestionResultModel;
}
