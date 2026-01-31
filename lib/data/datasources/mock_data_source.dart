import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user/user_model.dart';
import '../models/quiz_category/quiz_category_model.dart';
import '../../core/constants/app_constants.dart';

class MockDataSource {
  List<UserModel>? cachedUsers;
  final Map<String, List<QuizCategoryModel>> userCategoryProgress = {};

  Future<List<UserModel>> loadUsers() async {
    if (cachedUsers != null) {
      return cachedUsers!;
    }

    try {
      final jsonString = await rootBundle.loadString('assets/data/mock_users.json');
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final usersList = jsonData['users'] as List<dynamic>;
      
      cachedUsers = usersList
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
      
      return cachedUsers!;
    } catch (e) {
      return getDefaultUsers();
    }
  }

  // Get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    final users = await loadUsers();
    try {
      return users.firstWhere((user) => user.email == email);
    } catch (_) {
      return null;
    }
  }

  // Get all ranked users sorted by rank
  Future<List<UserModel>> getRankedUsers() async {
    final users = await loadUsers();
    final sortedUsers = List<UserModel>.from(users);
    sortedUsers.sort((a, b) => a.rank.compareTo(b.rank));
    return sortedUsers;
  }

  // Update user score
  Future<UserModel> updateUserScore(String userId, int scoreToAdd) async {
    final users = await loadUsers();
    final index = users.indexWhere((user) => user.id == userId);
    
    if (index != -1) {
      final updatedUser = users[index].copyWith(
        score: users[index].score + scoreToAdd,
      );
      cachedUsers![index] = updatedUser;
      
      recalculateRanks();
      
      return cachedUsers!.firstWhere((u) => u.id == userId);
    }
    
    throw Exception('User not found');
  }

  void recalculateRanks() {
    if (cachedUsers == null) return;
    
    cachedUsers!.sort((a, b) => b.score.compareTo(a.score));
    for (int i = 0; i < cachedUsers!.length; i++) {
      cachedUsers![i] = cachedUsers![i].copyWith(rank: i + 1);
    }
  }

  Future<List<QuizCategoryModel>> getCategoriesWithProgress(String userId) async {
    if (userCategoryProgress.containsKey(userId)) {
      return userCategoryProgress[userId]!;
    }

    final categories = AppConstants.quizCategories
        .map((cat) => QuizCategoryModel(
              id: cat['id'] as int,
              name: cat['name'] as String,
              icon: cat['icon'] as String,
              progress: 0,
              questionsAnswered: 0,
              totalQuestions: 10,
            ))
        .toList();

    userCategoryProgress[userId] = categories;
    return categories;
  }

  Future<void> updateCategoryProgress({
    required String userId,
    required int categoryId,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    final categories = await getCategoriesWithProgress(userId);
    final index = categories.indexWhere((c) => c.id == categoryId);
    
    if (index != -1) {
      final currentCategory = categories[index];
      final newProgress = ((correctAnswers / totalQuestions) * 100).round();
      
      final updatedCategory = currentCategory.copyWith(
        progress: newProgress > currentCategory.progress 
            ? newProgress 
            : currentCategory.progress,
        questionsAnswered: currentCategory.questionsAnswered + correctAnswers,
      );
      
      userCategoryProgress[userId]![index] = updatedCategory;
    }
  }

  List<UserModel> getDefaultUsers() {
    return [
      const UserModel(
        id: '1',
        name: 'Alex Thompson',
        email: 'alex.thompson@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        rank: 1,
        score: 9850,
      ),
      const UserModel(
        id: '2',
        name: 'Sarah Chen',
        email: 'sarah.chen@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        rank: 2,
        score: 9420,
      ),
      const UserModel(
        id: '3',
        name: 'Marcus Johnson',
        email: 'marcus.j@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        rank: 3,
        score: 8975,
      ),
      const UserModel(
        id: '4',
        name: 'Emily Rodriguez',
        email: 'emily.r@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=9',
        rank: 4,
        score: 8650,
      ),
      UserModel.testUser,
      const UserModel(
        id: '6',
        name: 'David Kim',
        email: 'david.kim@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=7',
        rank: 6,
        score: 7890,
      ),
      const UserModel(
        id: '7',
        name: 'Jessica Miller',
        email: 'jessica.m@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=10',
        rank: 7,
        score: 7540,
      ),
      const UserModel(
        id: '8',
        name: 'Ryan Cooper',
        email: 'ryan.cooper@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
        rank: 8,
        score: 7200,
      ),
      const UserModel(
        id: '9',
        name: 'Amanda Foster',
        email: 'amanda.f@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=16',
        rank: 9,
        score: 6850,
      ),
      const UserModel(
        id: '10',
        name: 'Chris Martinez',
        email: 'chris.m@email.com',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
        rank: 10,
        score: 6500,
      ),
    ];
  }
}
