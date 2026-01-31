// App constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Quiz Master';
  static const String appVersion = '1.0.0';

  // Valid Credentials
  static const String validEmail = 'test@gmail.com';
  static const String validPassword = 'Test@123';

  // API
  static const String triviaBaseUrl = 'https://opentdb.com';
  static const int questionsPerQuiz = 10;
  static const int questionTimeSeconds = 60;
  static const int countdownSeconds = 3;
  static const int feedbackDelayMs = 1000;

  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Quiz Categories with Open Trivia DB IDs
  static const List<Map<String, dynamic>> quizCategories = [
    {'id': 9, 'name': 'General Knowledge', 'icon': '🧠'},
    {'id': 17, 'name': 'Science & Nature', 'icon': '🔬'},
    {'id': 18, 'name': 'Computers', 'icon': '💻'},
    {'id': 19, 'name': 'Mathematics', 'icon': '🔢'},
    {'id': 20, 'name': 'Mythology', 'icon': '⚡'},
    {'id': 21, 'name': 'Sports', 'icon': '⚽'},
    {'id': 22, 'name': 'Geography', 'icon': '🌍'},
    {'id': 23, 'name': 'History', 'icon': '📜'},
    {'id': 25, 'name': 'Art', 'icon': '🎨'},
    {'id': 27, 'name': 'Animals', 'icon': '🦁'},
  ];
}

// Route paths for GoRouter
class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String ranking = '/ranking';
  static const String quiz = '/quiz/:categoryId';
  static const String result = '/result';

  static String quizWithId(int categoryId) => '/quiz/$categoryId';
}
