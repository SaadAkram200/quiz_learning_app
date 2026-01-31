// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$QuizResultModel {
  int get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get scoreEarned => throw _privateConstructorUsedError;
  Duration get timeTaken => throw _privateConstructorUsedError;
  List<QuestionResultModel> get questionResults =>
      throw _privateConstructorUsedError;

  /// Create a copy of QuizResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizResultModelCopyWith<QuizResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResultModelCopyWith<$Res> {
  factory $QuizResultModelCopyWith(
    QuizResultModel value,
    $Res Function(QuizResultModel) then,
  ) = _$QuizResultModelCopyWithImpl<$Res, QuizResultModel>;
  @useResult
  $Res call({
    int categoryId,
    String categoryName,
    int correctAnswers,
    int totalQuestions,
    int scoreEarned,
    Duration timeTaken,
    List<QuestionResultModel> questionResults,
  });
}

/// @nodoc
class _$QuizResultModelCopyWithImpl<$Res, $Val extends QuizResultModel>
    implements $QuizResultModelCopyWith<$Res> {
  _$QuizResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? correctAnswers = null,
    Object? totalQuestions = null,
    Object? scoreEarned = null,
    Object? timeTaken = null,
    Object? questionResults = null,
  }) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            scoreEarned: null == scoreEarned
                ? _value.scoreEarned
                : scoreEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            timeTaken: null == timeTaken
                ? _value.timeTaken
                : timeTaken // ignore: cast_nullable_to_non_nullable
                      as Duration,
            questionResults: null == questionResults
                ? _value.questionResults
                : questionResults // ignore: cast_nullable_to_non_nullable
                      as List<QuestionResultModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizResultModelImplCopyWith<$Res>
    implements $QuizResultModelCopyWith<$Res> {
  factory _$$QuizResultModelImplCopyWith(
    _$QuizResultModelImpl value,
    $Res Function(_$QuizResultModelImpl) then,
  ) = __$$QuizResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int categoryId,
    String categoryName,
    int correctAnswers,
    int totalQuestions,
    int scoreEarned,
    Duration timeTaken,
    List<QuestionResultModel> questionResults,
  });
}

/// @nodoc
class __$$QuizResultModelImplCopyWithImpl<$Res>
    extends _$QuizResultModelCopyWithImpl<$Res, _$QuizResultModelImpl>
    implements _$$QuizResultModelImplCopyWith<$Res> {
  __$$QuizResultModelImplCopyWithImpl(
    _$QuizResultModelImpl _value,
    $Res Function(_$QuizResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? correctAnswers = null,
    Object? totalQuestions = null,
    Object? scoreEarned = null,
    Object? timeTaken = null,
    Object? questionResults = null,
  }) {
    return _then(
      _$QuizResultModelImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        scoreEarned: null == scoreEarned
            ? _value.scoreEarned
            : scoreEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        timeTaken: null == timeTaken
            ? _value.timeTaken
            : timeTaken // ignore: cast_nullable_to_non_nullable
                  as Duration,
        questionResults: null == questionResults
            ? _value._questionResults
            : questionResults // ignore: cast_nullable_to_non_nullable
                  as List<QuestionResultModel>,
      ),
    );
  }
}

/// @nodoc

class _$QuizResultModelImpl extends _QuizResultModel {
  const _$QuizResultModelImpl({
    required this.categoryId,
    required this.categoryName,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.scoreEarned,
    required this.timeTaken,
    required final List<QuestionResultModel> questionResults,
  }) : _questionResults = questionResults,
       super._();

  @override
  final int categoryId;
  @override
  final String categoryName;
  @override
  final int correctAnswers;
  @override
  final int totalQuestions;
  @override
  final int scoreEarned;
  @override
  final Duration timeTaken;
  final List<QuestionResultModel> _questionResults;
  @override
  List<QuestionResultModel> get questionResults {
    if (_questionResults is EqualUnmodifiableListView) return _questionResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionResults);
  }

  @override
  String toString() {
    return 'QuizResultModel(categoryId: $categoryId, categoryName: $categoryName, correctAnswers: $correctAnswers, totalQuestions: $totalQuestions, scoreEarned: $scoreEarned, timeTaken: $timeTaken, questionResults: $questionResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizResultModelImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.scoreEarned, scoreEarned) ||
                other.scoreEarned == scoreEarned) &&
            (identical(other.timeTaken, timeTaken) ||
                other.timeTaken == timeTaken) &&
            const DeepCollectionEquality().equals(
              other._questionResults,
              _questionResults,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    categoryId,
    categoryName,
    correctAnswers,
    totalQuestions,
    scoreEarned,
    timeTaken,
    const DeepCollectionEquality().hash(_questionResults),
  );

  /// Create a copy of QuizResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizResultModelImplCopyWith<_$QuizResultModelImpl> get copyWith =>
      __$$QuizResultModelImplCopyWithImpl<_$QuizResultModelImpl>(
        this,
        _$identity,
      );
}

abstract class _QuizResultModel extends QuizResultModel {
  const factory _QuizResultModel({
    required final int categoryId,
    required final String categoryName,
    required final int correctAnswers,
    required final int totalQuestions,
    required final int scoreEarned,
    required final Duration timeTaken,
    required final List<QuestionResultModel> questionResults,
  }) = _$QuizResultModelImpl;
  const _QuizResultModel._() : super._();

  @override
  int get categoryId;
  @override
  String get categoryName;
  @override
  int get correctAnswers;
  @override
  int get totalQuestions;
  @override
  int get scoreEarned;
  @override
  Duration get timeTaken;
  @override
  List<QuestionResultModel> get questionResults;

  /// Create a copy of QuizResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizResultModelImplCopyWith<_$QuizResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QuestionResultModel {
  String get question => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  String? get userAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get timeSpentSeconds => throw _privateConstructorUsedError;

  /// Create a copy of QuestionResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionResultModelCopyWith<QuestionResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionResultModelCopyWith<$Res> {
  factory $QuestionResultModelCopyWith(
    QuestionResultModel value,
    $Res Function(QuestionResultModel) then,
  ) = _$QuestionResultModelCopyWithImpl<$Res, QuestionResultModel>;
  @useResult
  $Res call({
    String question,
    String correctAnswer,
    String? userAnswer,
    bool isCorrect,
    int timeSpentSeconds,
  });
}

/// @nodoc
class _$QuestionResultModelCopyWithImpl<$Res, $Val extends QuestionResultModel>
    implements $QuestionResultModelCopyWith<$Res> {
  _$QuestionResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAnswer = null,
    Object? userAnswer = freezed,
    Object? isCorrect = null,
    Object? timeSpentSeconds = null,
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
            userAnswer: freezed == userAnswer
                ? _value.userAnswer
                : userAnswer // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            timeSpentSeconds: null == timeSpentSeconds
                ? _value.timeSpentSeconds
                : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionResultModelImplCopyWith<$Res>
    implements $QuestionResultModelCopyWith<$Res> {
  factory _$$QuestionResultModelImplCopyWith(
    _$QuestionResultModelImpl value,
    $Res Function(_$QuestionResultModelImpl) then,
  ) = __$$QuestionResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String question,
    String correctAnswer,
    String? userAnswer,
    bool isCorrect,
    int timeSpentSeconds,
  });
}

/// @nodoc
class __$$QuestionResultModelImplCopyWithImpl<$Res>
    extends _$QuestionResultModelCopyWithImpl<$Res, _$QuestionResultModelImpl>
    implements _$$QuestionResultModelImplCopyWith<$Res> {
  __$$QuestionResultModelImplCopyWithImpl(
    _$QuestionResultModelImpl _value,
    $Res Function(_$QuestionResultModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? correctAnswer = null,
    Object? userAnswer = freezed,
    Object? isCorrect = null,
    Object? timeSpentSeconds = null,
  }) {
    return _then(
      _$QuestionResultModelImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as String,
        userAnswer: freezed == userAnswer
            ? _value.userAnswer
            : userAnswer // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        timeSpentSeconds: null == timeSpentSeconds
            ? _value.timeSpentSeconds
            : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$QuestionResultModelImpl implements _QuestionResultModel {
  const _$QuestionResultModelImpl({
    required this.question,
    required this.correctAnswer,
    this.userAnswer,
    required this.isCorrect,
    required this.timeSpentSeconds,
  });

  @override
  final String question;
  @override
  final String correctAnswer;
  @override
  final String? userAnswer;
  @override
  final bool isCorrect;
  @override
  final int timeSpentSeconds;

  @override
  String toString() {
    return 'QuestionResultModel(question: $question, correctAnswer: $correctAnswer, userAnswer: $userAnswer, isCorrect: $isCorrect, timeSpentSeconds: $timeSpentSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionResultModelImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.timeSpentSeconds, timeSpentSeconds) ||
                other.timeSpentSeconds == timeSpentSeconds));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    question,
    correctAnswer,
    userAnswer,
    isCorrect,
    timeSpentSeconds,
  );

  /// Create a copy of QuestionResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionResultModelImplCopyWith<_$QuestionResultModelImpl> get copyWith =>
      __$$QuestionResultModelImplCopyWithImpl<_$QuestionResultModelImpl>(
        this,
        _$identity,
      );
}

abstract class _QuestionResultModel implements QuestionResultModel {
  const factory _QuestionResultModel({
    required final String question,
    required final String correctAnswer,
    final String? userAnswer,
    required final bool isCorrect,
    required final int timeSpentSeconds,
  }) = _$QuestionResultModelImpl;

  @override
  String get question;
  @override
  String get correctAnswer;
  @override
  String? get userAnswer;
  @override
  bool get isCorrect;
  @override
  int get timeSpentSeconds;

  /// Create a copy of QuestionResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionResultModelImplCopyWith<_$QuestionResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
