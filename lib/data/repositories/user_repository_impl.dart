import '../../domain/repositories/user_repository.dart';
import '../datasources/mock_data_source.dart';
import '../models/user/user_model.dart';
import '../models/quiz_category/quiz_category_model.dart';

// User repository implementation
class UserRepositoryImpl implements UserRepository {
  final MockDataSource _mockDataSource;

  UserRepositoryImpl(this._mockDataSource);

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    return await _mockDataSource.getUserByEmail(email);
  }

  @override
  Future<UserModel> updateUserScore(String userId, int scoreToAdd) async {
    return await _mockDataSource.updateUserScore(userId, scoreToAdd);
  }

  @override
  Future<List<QuizCategoryModel>> getCategoriesWithProgress(String userId) async {
    return await _mockDataSource.getCategoriesWithProgress(userId);
  }

  @override
  Future<void> updateCategoryProgress({
    required String userId,
    required int categoryId,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    await _mockDataSource.updateCategoryProgress(
      userId: userId,
      categoryId: categoryId,
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
    );
  }
}
