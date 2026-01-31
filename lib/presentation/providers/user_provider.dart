import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/injection.dart';
import '../../data/models/quiz_category/quiz_category_model.dart';
import '../../domain/repositories/user_repository.dart';
import 'auth_provider.dart';

// User repository provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return getIt<UserRepository>();
});

// Categories with progress provider
final categoriesProvider = FutureProvider<List<QuizCategoryModel>>((ref) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) {
    return [];
  }

  final repository = ref.watch(userRepositoryProvider);
  return await repository.getCategoriesWithProgress(currentUser.id);
});

// Single category provider
final categoryProvider = Provider.family<QuizCategoryModel?, int>((ref, categoryId) {
  final categoriesAsync = ref.watch(categoriesProvider);
  return categoriesAsync.whenOrNull(
    data: (categories) {
      try {
        return categories.firstWhere((c) => c.id == categoryId);
      } catch (_) {
        return null;
      }
    },
  );
});
