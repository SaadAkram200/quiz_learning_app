// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$QuizStateModel {
  QuizStatus get status => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  List<QuestionModel> get questions => throw _privateConstructorUsedError;
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  int get timeRemainingSeconds => throw _privateConstructorUsedError;
  String? get selectedAnswer => throw _privateConstructorUsedError;
  bool? get isCorrect => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get countdownValue => throw _privateConstructorUsedError;
  List<QuestionResultModel> get questionResults =>
      throw _privateConstructorUsedError;
  QuizResultModel? get result => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get quizStartTime => throw _privateConstructorUsedError;

  /// Create a copy of QuizStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizStateModelCopyWith<QuizStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizStateModelCopyWith<$Res> {
  factory $QuizStateModelCopyWith(
    QuizStateModel value,
    $Res Function(QuizStateModel) then,
  ) = _$QuizStateModelCopyWithImpl<$Res, QuizStateModel>;
  @useResult
  $Res call({
    QuizStatus status,
    int categoryId,
    String categoryName,
    List<QuestionModel> questions,
    int currentQuestionIndex,
    int timeRemainingSeconds,
    String? selectedAnswer,
    bool? isCorrect,
    int correctAnswers,
    int countdownValue,
    List<QuestionResultModel> questionResults,
    QuizResultModel? result,
    String? errorMessage,
    DateTime? quizStartTime,
  });

  $QuizResultModelCopyWith<$Res>? get result;
}

/// @nodoc
class _$QuizStateModelCopyWithImpl<$Res, $Val extends QuizStateModel>
    implements $QuizStateModelCopyWith<$Res> {
  _$QuizStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? questions = null,
    Object? currentQuestionIndex = null,
    Object? timeRemainingSeconds = null,
    Object? selectedAnswer = freezed,
    Object? isCorrect = freezed,
    Object? correctAnswers = null,
    Object? countdownValue = null,
    Object? questionResults = null,
    Object? result = freezed,
    Object? errorMessage = freezed,
    Object? quizStartTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as QuizStatus,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<QuestionModel>,
            currentQuestionIndex: null == currentQuestionIndex
                ? _value.currentQuestionIndex
                : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            timeRemainingSeconds: null == timeRemainingSeconds
                ? _value.timeRemainingSeconds
                : timeRemainingSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedAnswer: freezed == selectedAnswer
                ? _value.selectedAnswer
                : selectedAnswer // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCorrect: freezed == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool?,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            countdownValue: null == countdownValue
                ? _value.countdownValue
                : countdownValue // ignore: cast_nullable_to_non_nullable
                      as int,
            questionResults: null == questionResults
                ? _value.questionResults
                : questionResults // ignore: cast_nullable_to_non_nullable
                      as List<QuestionResultModel>,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as QuizResultModel?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            quizStartTime: freezed == quizStartTime
                ? _value.quizStartTime
                : quizStartTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of QuizStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuizResultModelCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $QuizResultModelCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuizStateModelImplCopyWith<$Res>
    implements $QuizStateModelCopyWith<$Res> {
  factory _$$QuizStateModelImplCopyWith(
    _$QuizStateModelImpl value,
    $Res Function(_$QuizStateModelImpl) then,
  ) = __$$QuizStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    QuizStatus status,
    int categoryId,
    String categoryName,
    List<QuestionModel> questions,
    int currentQuestionIndex,
    int timeRemainingSeconds,
    String? selectedAnswer,
    bool? isCorrect,
    int correctAnswers,
    int countdownValue,
    List<QuestionResultModel> questionResults,
    QuizResultModel? result,
    String? errorMessage,
    DateTime? quizStartTime,
  });

  @override
  $QuizResultModelCopyWith<$Res>? get result;
}

/// @nodoc
class __$$QuizStateModelImplCopyWithImpl<$Res>
    extends _$QuizStateModelCopyWithImpl<$Res, _$QuizStateModelImpl>
    implements _$$QuizStateModelImplCopyWith<$Res> {
  __$$QuizStateModelImplCopyWithImpl(
    _$QuizStateModelImpl _value,
    $Res Function(_$QuizStateModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? questions = null,
    Object? currentQuestionIndex = null,
    Object? timeRemainingSeconds = null,
    Object? selectedAnswer = freezed,
    Object? isCorrect = freezed,
    Object? correctAnswers = null,
    Object? countdownValue = null,
    Object? questionResults = null,
    Object? result = freezed,
    Object? errorMessage = freezed,
    Object? quizStartTime = freezed,
  }) {
    return _then(
      _$QuizStateModelImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as QuizStatus,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<QuestionModel>,
        currentQuestionIndex: null == currentQuestionIndex
            ? _value.currentQuestionIndex
            : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        timeRemainingSeconds: null == timeRemainingSeconds
            ? _value.timeRemainingSeconds
            : timeRemainingSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedAnswer: freezed == selectedAnswer
            ? _value.selectedAnswer
            : selectedAnswer // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCorrect: freezed == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool?,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        countdownValue: null == countdownValue
            ? _value.countdownValue
            : countdownValue // ignore: cast_nullable_to_non_nullable
                  as int,
        questionResults: null == questionResults
            ? _value._questionResults
            : questionResults // ignore: cast_nullable_to_non_nullable
                  as List<QuestionResultModel>,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as QuizResultModel?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        quizStartTime: freezed == quizStartTime
            ? _value.quizStartTime
            : quizStartTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$QuizStateModelImpl extends _QuizStateModel {
  const _$QuizStateModelImpl({
    this.status = QuizStatus.initial,
    this.categoryId = 0,
    this.categoryName = '',
    final List<QuestionModel> questions = const [],
    this.currentQuestionIndex = 0,
    this.timeRemainingSeconds = 60,
    this.selectedAnswer,
    this.isCorrect,
    this.correctAnswers = 0,
    this.countdownValue = 3,
    final List<QuestionResultModel> questionResults = const [],
    this.result,
    this.errorMessage,
    this.quizStartTime,
  }) : _questions = questions,
       _questionResults = questionResults,
       super._();

  @override
  @JsonKey()
  final QuizStatus status;
  @override
  @JsonKey()
  final int categoryId;
  @override
  @JsonKey()
  final String categoryName;
  final List<QuestionModel> _questions;
  @override
  @JsonKey()
  List<QuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  @JsonKey()
  final int currentQuestionIndex;
  @override
  @JsonKey()
  final int timeRemainingSeconds;
  @override
  final String? selectedAnswer;
  @override
  final bool? isCorrect;
  @override
  @JsonKey()
  final int correctAnswers;
  @override
  @JsonKey()
  final int countdownValue;
  final List<QuestionResultModel> _questionResults;
  @override
  @JsonKey()
  List<QuestionResultModel> get questionResults {
    if (_questionResults is EqualUnmodifiableListView) return _questionResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionResults);
  }

  @override
  final QuizResultModel? result;
  @override
  final String? errorMessage;
  @override
  final DateTime? quizStartTime;

  @override
  String toString() {
    return 'QuizStateModel(status: $status, categoryId: $categoryId, categoryName: $categoryName, questions: $questions, currentQuestionIndex: $currentQuestionIndex, timeRemainingSeconds: $timeRemainingSeconds, selectedAnswer: $selectedAnswer, isCorrect: $isCorrect, correctAnswers: $correctAnswers, countdownValue: $countdownValue, questionResults: $questionResults, result: $result, errorMessage: $errorMessage, quizStartTime: $quizStartTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizStateModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.timeRemainingSeconds, timeRemainingSeconds) ||
                other.timeRemainingSeconds == timeRemainingSeconds) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.countdownValue, countdownValue) ||
                other.countdownValue == countdownValue) &&
            const DeepCollectionEquality().equals(
              other._questionResults,
              _questionResults,
            ) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.quizStartTime, quizStartTime) ||
                other.quizStartTime == quizStartTime));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    categoryId,
    categoryName,
    const DeepCollectionEquality().hash(_questions),
    currentQuestionIndex,
    timeRemainingSeconds,
    selectedAnswer,
    isCorrect,
    correctAnswers,
    countdownValue,
    const DeepCollectionEquality().hash(_questionResults),
    result,
    errorMessage,
    quizStartTime,
  );

  /// Create a copy of QuizStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizStateModelImplCopyWith<_$QuizStateModelImpl> get copyWith =>
      __$$QuizStateModelImplCopyWithImpl<_$QuizStateModelImpl>(
        this,
        _$identity,
      );
}

abstract class _QuizStateModel extends QuizStateModel {
  const factory _QuizStateModel({
    final QuizStatus status,
    final int categoryId,
    final String categoryName,
    final List<QuestionModel> questions,
    final int currentQuestionIndex,
    final int timeRemainingSeconds,
    final String? selectedAnswer,
    final bool? isCorrect,
    final int correctAnswers,
    final int countdownValue,
    final List<QuestionResultModel> questionResults,
    final QuizResultModel? result,
    final String? errorMessage,
    final DateTime? quizStartTime,
  }) = _$QuizStateModelImpl;
  const _QuizStateModel._() : super._();

  @override
  QuizStatus get status;
  @override
  int get categoryId;
  @override
  String get categoryName;
  @override
  List<QuestionModel> get questions;
  @override
  int get currentQuestionIndex;
  @override
  int get timeRemainingSeconds;
  @override
  String? get selectedAnswer;
  @override
  bool? get isCorrect;
  @override
  int get correctAnswers;
  @override
  int get countdownValue;
  @override
  List<QuestionResultModel> get questionResults;
  @override
  QuizResultModel? get result;
  @override
  String? get errorMessage;
  @override
  DateTime? get quizStartTime;

  /// Create a copy of QuizStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizStateModelImplCopyWith<_$QuizStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
