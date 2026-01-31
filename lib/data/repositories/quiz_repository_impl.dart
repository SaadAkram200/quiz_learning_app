import '../../domain/repositories/quiz_repository.dart';
import '../datasources/trivia_api.dart';
import '../models/question/question_model.dart';

// Quiz repository implementation
class QuizRepositoryImpl implements QuizRepository {
  final TriviaApi _triviaApi;

  QuizRepositoryImpl(this._triviaApi);

  @override
  Future<List<QuestionModel>> getQuestions({
    required int categoryId,
    int amount = 10,
    String? difficulty,
  }) async {
    try {
      final questions = await _triviaApi.fetchQuestions(
        categoryId: categoryId,
        amount: amount,
        difficulty: difficulty,
      );
      return questions;
    } on TriviaApiException {
      rethrow;
    } catch (e) {
      throw TriviaApiException('Failed to fetch questions: $e', 500);
    }
  }
}
