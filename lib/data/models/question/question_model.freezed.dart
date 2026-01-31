// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$QuestionModel {
  String get question => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  List<String> get incorrectAnswers => throw _privateConstructorUsedError;
  List<String> get allAnswers => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionModelCopyWith<QuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionModelCopyWith<$Res> {
  factory $QuestionModelCopyWith(
    QuestionModel value,
    $Res Function(QuestionModel) then,
  ) = _$QuestionModelCopyWithImpl<$Res, QuestionModel>;
  @useResult
  $Res call({
    String question,
    String correctAnswer,
    List<String> incorrectAnswers,
    List<String> allAnswers,
    String category,
    String difficulty,
    String type,
  });
}

/// @nodoc
class _$QuestionModelCopyWithImpl<$Res, $Val extends QuestionModel>
    implements $QuestionModelCopyWith<$Res> {
  _$QuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAnswer = null,
    Object? incorrectAnswers = null,
    Object? allAnswers = null,
    Object? category = null,
    Object? difficulty = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as String,
            incorrectAnswers: null == incorrectAnswers
                ? _value.incorrectAnswers
                : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            allAnswers: null == allAnswers
                ? _value.allAnswers
                : allAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionModelImplCopyWith<$Res>
    implements $QuestionModelCopyWith<$Res> {
  factory _$$QuestionModelImplCopyWith(
    _$QuestionModelImpl value,
    $Res Function(_$QuestionModelImpl) then,
  ) = __$$QuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String question,
    String correctAnswer,
    List<String> incorrectAnswers,
    List<String> allAnswers,
    String category,
    String difficulty,
    String type,
  });
}

/// @nodoc
class __$$QuestionModelImplCopyWithImpl<$Res>
    extends _$QuestionModelCopyWithImpl<$Res, _$QuestionModelImpl>
    implements _$$QuestionModelImplCopyWith<$Res> {
  __$$QuestionModelImplCopyWithImpl(
    _$QuestionModelImpl _value,
    $Res Function(_$QuestionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAnswer = null,
    Object? incorrectAnswers = null,
    Object? allAnswers = null,
    Object? category = null,
    Object? difficulty = null,
    Object? type = null,
  }) {
    return _then(
      _$QuestionModelImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as String,
        incorrectAnswers: null == incorrectAnswers
            ? _value._incorrectAnswers
            : incorrectAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        allAnswers: null == allAnswers
            ? _value._allAnswers
            : allAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$QuestionModelImpl extends _QuestionModel {
  const _$QuestionModelImpl({
    required this.question,
    required this.correctAnswer,
    required final List<String> incorrectAnswers,
    final List<String> allAnswers = const [],
    required this.category,
    required this.difficulty,
    required this.type,
  }) : _incorrectAnswers = incorrectAnswers,
       _allAnswers = allAnswers,
       super._();

  @override
  final String question;
  @override
  final String correctAnswer;
  final List<String> _incorrectAnswers;
  @override
  List<String> get incorrectAnswers {
    if (_incorrectAnswers is EqualUnmodifiableListView)
      return _incorrectAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incorrectAnswers);
  }

  final List<String> _allAnswers;
  @override
  @JsonKey()
  List<String> get allAnswers {
    if (_allAnswers is EqualUnmodifiableListView) return _allAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allAnswers);
  }

  @override
  final String category;
  @override
  final String difficulty;
  @override
  final String type;

  @override
  String toString() {
    return 'QuestionModel(question: $question, correctAnswer: $correctAnswer, incorrectAnswers: $incorrectAnswers, allAnswers: $allAnswers, category: $category, difficulty: $difficulty, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            const DeepCollectionEquality().equals(
              other._incorrectAnswers,
              _incorrectAnswers,
            ) &&
            const DeepCollectionEquality().equals(
              other._allAnswers,
              _allAnswers,
            ) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    question,
    correctAnswer,
    const DeepCollectionEquality().hash(_incorrectAnswers),
    const DeepCollectionEquality().hash(_allAnswers),
    category,
    difficulty,
    type,
  );

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionModelImplCopyWith<_$QuestionModelImpl> get copyWith =>
      __$$QuestionModelImplCopyWithImpl<_$QuestionModelImpl>(this, _$identity);
}

abstract class _QuestionModel extends QuestionModel {
  const factory _QuestionModel({
    required final String question,
    required final String correctAnswer,
    required final List<String> incorrectAnswers,
    final List<String> allAnswers,
    required final String category,
    required final String difficulty,
    required final String type,
  }) = _$QuestionModelImpl;
  const _QuestionModel._() : super._();

  @override
  String get question;
  @override
  String get correctAnswer;
  @override
  List<String> get incorrectAnswers;
  @override
  List<String> get allAnswers;
  @override
  String get category;
  @override
  String get difficulty;
  @override
  String get type;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionModelImplCopyWith<_$QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
