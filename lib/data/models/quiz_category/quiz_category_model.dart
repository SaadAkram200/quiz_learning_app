import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_category_model.freezed.dart';
part 'quiz_category_model.g.dart';

@freezed
abstract class QuizCategoryModel with _$QuizCategoryModel {
  const factory QuizCategoryModel({
    required int id,
    required String name,
    required String icon,
    @Default(0) int progress,
    @Default(0) int questionsAnswered,
    @Default(10) int totalQuestions,
  }) = _QuizCategoryModel;

  factory QuizCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$QuizCategoryModelFromJson(json);
}
