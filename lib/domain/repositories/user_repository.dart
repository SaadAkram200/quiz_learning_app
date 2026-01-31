import '../../data/models/user/user_model.dart';
import '../../data/models/quiz_category/quiz_category_model.dart';

/// Abstract user repository interface
abstract class UserRepository {
  /// Get user by email
  Future<UserModel?> getUserByEmail(String email);

  /// Update user score
  Future<UserModel> updateUserScore(String userId, int scoreToAdd);

  /// Get quiz categories with progress for a user
  Future<List<QuizCategoryModel>> getCategoriesWithProgress(String userId);

  // Update category progress after quiz completion
  Future<void> updateCategoryProgress({
    required String userId,
    required int categoryId,
    required int correctAnswers,
    required int totalQuestions,
  });
}
