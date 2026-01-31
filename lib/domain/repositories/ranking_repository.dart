import '../../data/models/user/user_model.dart';

// Abstract ranking repository interface
abstract class RankingRepository {
  Future<List<UserModel>> getRankedUsers();

  Future<int> getUserRank(String userId);
}
