import 'package:freezed_annotation/freezed_annotation.dart';
import '../user/user_model.dart';

part 'auth_state_model.freezed.dart';

@freezed
abstract class AuthStateModel with _$AuthStateModel {
  const factory AuthStateModel({
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    UserModel? user,
    String? errorMessage,
  }) = _AuthStateModel;

  // Initial unauthenticated state
  factory AuthStateModel.initial() => const AuthStateModel();

  // Loading state
  factory AuthStateModel.loading() => const AuthStateModel(isLoading: true);

  // Authenticated state
  factory AuthStateModel.authenticated(UserModel user) => AuthStateModel(
        isAuthenticated: true,
        user: user,
      );

  // Error state
  factory AuthStateModel.error(String message) => AuthStateModel(
        errorMessage: message,
      );
}
