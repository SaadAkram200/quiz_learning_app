import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/injection.dart';
import '../../data/models/user/user_model.dart';
import '../../domain/repositories/ranking_repository.dart';

// Ranking repository provider
final rankingRepositoryProvider = Provider<RankingRepository>((ref) {
  return getIt<RankingRepository>();
});

// Ranked users provider
final rankedUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  final repository = ref.watch(rankingRepositoryProvider);
  return await repository.getRankedUsers();
});

// Refresh ranked users
final refreshRankingProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    ref.invalidate(rankedUsersProvider);
  };
});
