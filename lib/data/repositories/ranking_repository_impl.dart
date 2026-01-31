import '../../domain/repositories/ranking_repository.dart';
import '../datasources/mock_data_source.dart';
import '../models/user/user_model.dart';

// Ranking repository implementation
class RankingRepositoryImpl implements RankingRepository {
  final MockDataSource _mockDataSource;

  RankingRepositoryImpl(this._mockDataSource);

  @override
  Future<List<UserModel>> getRankedUsers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return await _mockDataSource.getRankedUsers();
  }

  @override
  Future<int> getUserRank(String userId) async {
    final users = await getRankedUsers();
    final user = users.firstWhere(
      (u) => u.id == userId,
      orElse: () => throw Exception('User not found'),
    );
    return user.rank;
  }
}
