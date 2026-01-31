import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/injection.dart';
import '../../data/models/auth/auth_state_model.dart';
import '../../data/models/user/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return getIt<AuthRepository>();
});

// Auth state notifier provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthStateModel>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

// Check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

// Current user provider
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authProvider).user;
});

// Auth state notifier
class AuthNotifier extends StateNotifier<AuthStateModel> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthStateModel.initial()) {
    // Check for existing session on initialization
    checkExistingSession();
  }

  void checkExistingSession() {
    if (_authRepository.isAuthenticated && _authRepository.currentUser != null) {
      state = AuthStateModel.authenticated(_authRepository.currentUser!);
    }
  }

  // Login with email and password
  Future<bool> login(String email, String password) async {
    state = AuthStateModel.loading();

    try {
      final user = await _authRepository.login(email, password);
      state = AuthStateModel.authenticated(user);
      return true;
    } on AuthException catch (e) {
      state = AuthStateModel.error(e.message);
      return false;
    } catch (e) {
      state = AuthStateModel.error('An unexpected error occurred');
      return false;
    }
  }

  // Logout current user
  Future<void> logout() async {
    try {
      await _authRepository.logout();
      state = AuthStateModel.initial();
    } catch (e) {
      // Even if logout fails, clear local state
      state = AuthStateModel.initial();
    }
  }

  // Update user (e.g., when score changes)
  Future<void> updateUser(UserModel user) async {
    if (state.isAuthenticated) {
      state = state.copyWith(user: user);
      
      // Also update in repository (and persist to storage)
      if (_authRepository is AuthRepositoryImpl) {
        await (_authRepository).updateCurrentUser(user);
      }
    }
  }

  // Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
