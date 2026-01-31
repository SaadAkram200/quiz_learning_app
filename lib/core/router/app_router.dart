import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../constants/app_constants.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/ranking/ranking_screen.dart';
import '../../presentation/screens/quiz/quiz_screen.dart';
import '../../presentation/screens/result/result_screen.dart';
import '../../presentation/widgets/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  
  final isAuthenticated = ref.watch(
    authProvider.select((state) => state.isAuthenticated),
  );

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login;

      if (!isAuthenticated && !isLoggingIn) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isLoggingIn) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ranking,
                builder: (context, state) => const RankingScreen(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.quiz,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final categoryId =
              int.tryParse(state.pathParameters['categoryId'] ?? '') ?? 0;
          final categoryName = state.uri.queryParameters['name'] ?? 'Quiz';
          return QuizScreen(categoryId: categoryId, categoryName: categoryName);
        },
      ),

      GoRoute(
        path: AppRoutes.result,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ResultScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            16.vBox,
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            8.vBox,
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            24.vBox,
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
