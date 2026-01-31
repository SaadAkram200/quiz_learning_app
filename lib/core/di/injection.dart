import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../../data/datasources/trivia_api.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../data/datasources/session_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/quiz_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/ranking_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/ranking_repository.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  await registerExternalDependencies();

  registerDataSources();

  registerRepositories();
}

Future<void> registerExternalDependencies() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.triviaBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  getIt.registerSingleton<Dio>(dio);

  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register SessionStorage
  getIt.registerSingleton<SessionStorage>(SessionStorage(sharedPreferences));
}

void registerDataSources() {
  getIt.registerLazySingleton<TriviaApi>(() => TriviaApi(getIt<Dio>()));

  getIt.registerLazySingleton<MockDataSource>(() => MockDataSource());
}

void registerRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sessionStorage: getIt<SessionStorage>()),
  );

  getIt.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(getIt<TriviaApi>()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<MockDataSource>()),
  );

  getIt.registerLazySingleton<RankingRepository>(
    () => RankingRepositoryImpl(getIt<MockDataSource>()),
  );
}
