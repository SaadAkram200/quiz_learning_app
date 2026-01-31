// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizCategoryModelImpl _$$QuizCategoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$QuizCategoryModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  icon: json['icon'] as String,
  progress: (json['progress'] as num?)?.toInt() ?? 0,
  questionsAnswered: (json['questionsAnswered'] as num?)?.toInt() ?? 0,
  totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 10,
);

Map<String, dynamic> _$$QuizCategoryModelImplToJson(
  _$QuizCategoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'progress': instance.progress,
  'questionsAnswered': instance.questionsAnswered,
  'totalQuestions': instance.totalQuestions,
};
