import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_learning_app/core/constants/app_constants.dart';
import 'package:quiz_learning_app/data/repositories/auth_repository_impl.dart';
import 'package:quiz_learning_app/data/models/user/user_model.dart';

void main() {
  late AuthRepositoryImpl authRepository;

  setUp(() {
    authRepository = AuthRepositoryImpl();
  });

  group('AuthRepository', () {
    group('login', () {
      test('should return user when credentials are valid', () async {
        const email = AppConstants.validEmail;
        const password = AppConstants.validPassword;

        final result = await authRepository.login(email, password);

        expect(result, isA<UserModel>());
        expect(result.email, email);
        expect(authRepository.isAuthenticated, true);
        expect(authRepository.currentUser, isNotNull);
      });

      test('should throw AuthException when email is invalid', () async {
        const email = 'invalid@email.com';
        const password = AppConstants.validPassword;

        expect(
          () => authRepository.login(email, password),
          throwsA(isA<AuthException>()),
        );
      });

      test('should throw AuthException when password is invalid', () async {
        const email = AppConstants.validEmail;
        const password = 'wrongpassword';

        expect(
          () => authRepository.login(email, password),
          throwsA(isA<AuthException>()),
        );
      });

      test('should throw AuthException with correct message', () async {
        const email = 'wrong@email.com';
        const password = 'wrongpassword';

        try {
          await authRepository.login(email, password);
          fail('Should have thrown AuthException');
        } on AuthException catch (e) {
          expect(e.message, 'Invalid email or password, please try again');
        }
      });
    });

    group('logout', () {
      test('should clear authentication state', () async {
        await authRepository.login(
          AppConstants.validEmail,
          AppConstants.validPassword,
        );
        expect(authRepository.isAuthenticated, true);
        await authRepository.logout();

        expect(authRepository.isAuthenticated, false);
        expect(authRepository.currentUser, isNull);
      });
    });

    group('isAuthenticated', () {
      test('should return false initially', () {
        expect(authRepository.isAuthenticated, false);
      });

      test('should return true after successful login', () async {
        await authRepository.login(
          AppConstants.validEmail,
          AppConstants.validPassword,
        );

        expect(authRepository.isAuthenticated, true);
      });
    });

    group('currentUser', () {
      test('should return null when not authenticated', () {
        expect(authRepository.currentUser, isNull);
      });

      test('should return user after successful login', () async {
        await authRepository.login(
          AppConstants.validEmail,
          AppConstants.validPassword,
        );

        expect(authRepository.currentUser, isNotNull);
        expect(authRepository.currentUser?.email, AppConstants.validEmail);
      });
    });

    group('updateCurrentUser', () {
      test('should update current user when authenticated', () async {
        await authRepository.login(
          AppConstants.validEmail,
          AppConstants.validPassword,
        );
        final originalScore = authRepository.currentUser!.score;
        final updatedUser = authRepository.currentUser!.copyWith(
          score: originalScore + 100,
        );

        authRepository.updateCurrentUser(updatedUser);

        expect(authRepository.currentUser?.score, originalScore + 100);
      });

      test('should not update when not authenticated', () {
        const updatedUser = UserModel(
          id: '1',
          name: 'Test',
          email: 'test@test.com',
          avatarUrl: '',
          rank: 1,
          score: 1000,
        );

        authRepository.updateCurrentUser(updatedUser);

        expect(authRepository.currentUser, isNull);
      });
    });
  });
}
