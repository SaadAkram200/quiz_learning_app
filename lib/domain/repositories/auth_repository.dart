import '../../data/models/user/user_model.dart';

// Abstract authentication repository interface
abstract class AuthRepository {
  Future<UserModel> login(String email, String password);

  Future<void> logout();

  bool get isAuthenticated;

  UserModel? get currentUser;
}
