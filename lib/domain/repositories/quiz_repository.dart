import '../../data/models/question/question_model.dart';

// Abstract quiz repository interface
abstract class QuizRepository {
  Future<List<QuestionModel>> getQuestions({
    required int categoryId,
    int amount = 10,
    String? difficulty,
  });
}
