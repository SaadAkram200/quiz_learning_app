import '../../core/constants/app_constants.dart';
import '../../core/di/injection.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/session_storage.dart';
import '../models/user/user_model.dart';

// Authentication repository implementation
class AuthRepositoryImpl implements AuthRepository {
  UserModel? _currentUser;
  bool _isAuthenticated = false;

  final SessionStorage? _sessionStorage;

  AuthRepositoryImpl({SessionStorage? sessionStorage})
      : _sessionStorage = sessionStorage ?? _tryGetSessionStorage() {
    restoreSession();
  }

  static SessionStorage? _tryGetSessionStorage() {
    try {
      if (getIt.isRegistered<SessionStorage>()) {
        return getIt<SessionStorage>();
      }
    } catch (_) {}
    return null;
  }

  void restoreSession() {
    if (_sessionStorage?.isLoggedIn() == true) {
      final cachedUser = _sessionStorage?.getCachedUser();
      if (cachedUser != null) {
        _currentUser = cachedUser;
        _isAuthenticated = true;
      }
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (email != AppConstants.validEmail || password != AppConstants.validPassword) {
      throw AuthException('Invalid email or password, please try again');
    }

    _currentUser = UserModel.testUser;
    _isAuthenticated = true;

    await _sessionStorage?.saveSession(_currentUser!);

    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await _sessionStorage?.clearSession();

    _currentUser = null;
    _isAuthenticated = false;
  }

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  UserModel? get currentUser => _currentUser;

  Future<void> updateCurrentUser(UserModel user) async {
    if (_isAuthenticated) {
      _currentUser = user;
      await _sessionStorage?.updateCachedUser(user);
    }
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}
