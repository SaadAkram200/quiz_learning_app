import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html_unescape/html_unescape.dart';

part 'question_model.freezed.dart';

@freezed
abstract class QuestionModel with _$QuestionModel {
  const QuestionModel._();

  const factory QuestionModel({
    required String question,
    required String correctAnswer,
    required List<String> incorrectAnswers,
    @Default([])
    List<String> allAnswers,
    required String category,
    required String difficulty,
    required String type,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final unescape = HtmlUnescape();

    final correctAnswer = unescape.convert(json['correct_answer'] as String);
    final incorrectAnswers = (json['incorrect_answers'] as List<dynamic>)
        .map((e) => unescape.convert(e as String))
        .toList();

    // Combine and shuffle answers
    final allAnswers = [...incorrectAnswers, correctAnswer];
    allAnswers.shuffle();

    return QuestionModel(
      question: unescape.convert(json['question'] as String),
      correctAnswer: correctAnswer,
      incorrectAnswers: incorrectAnswers,
      allAnswers: allAnswers,
      category: unescape.convert(json['category'] as String),
      difficulty: json['difficulty'] as String,
      type: json['type'] as String,
    );
  }

  // Check if the provided answer is correct
  bool isCorrectAnswer(String answer) => answer == correctAnswer;
}
