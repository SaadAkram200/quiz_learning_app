# Quiz Learning App

A responsive Flutter Quiz Learning App that works on both Web and Mobile platforms. This app demonstrates clean architecture, state management with Riverpod, routing with GoRouter, and a playable quiz flow using the Open Trivia DB API.

## Features

- **Authentication**: Login screen with email/password validation
- **Responsive Design**: Works seamlessly on Web, iOS, and Android
- **Tab Navigation**: Profile, Home, and Ranking tabs with responsive navigation
- **Quiz Gameplay**: 
  - 10 quiz categories from Open Trivia DB
  - 3-2-1 countdown animation before quiz starts
  - 60-second timer per question
  - Immediate feedback with correct/incorrect highlighting
  - Progress tracking and score calculation
- **User Profile**: Display user info, stats, and logout functionality
- **Leaderboard**: Ranking system with top 10 users

## Screenshots

The app features:
- Modern UI with gradient backgrounds and smooth animations
- Bottom navigation on mobile, side rail on desktop
- Animated countdown, timer bar, and confetti on quiz completion

## Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns:

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # MaterialApp configuration
├── core/
│   ├── constants/            # App-wide constants
│   ├── theme/                # Theme and colors
│   ├── utils/                # Utility functions
│   ├── di/                   # Dependency injection (GetIt)
│   └── router/               # GoRouter configuration
├── data/
│   ├── models/               # Data models
│   ├── repositories/         # Repository implementations
│   └── datasources/          # API clients and mock data
├── domain/
│   └── repositories/         # Repository interfaces
└── presentation/
    ├── providers/            # Riverpod state providers
    ├── screens/              # Screen widgets
    └── widgets/              # Reusable UI components
```

## Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter 3.10+ |
| State Management | Riverpod |
| Routing | GoRouter |
| Dependency Injection | GetIt |
| HTTP Client | Dio |
| Testing | flutter_test, mockito |

## Getting Started

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Dart SDK 3.10.0 or higher
- Chrome (for web development)
- Xcode (for iOS) or Android Studio (for Android)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/quiz_learning_app.git
   cd quiz_learning_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**

   **Web:**
   ```bash
   flutter run -d chrome
   ```

   **iOS:**
   ```bash
   flutter run -d ios
   ```

   **Android:**
   ```bash
   flutter run -d android
   ```

   **macOS:**
   ```bash
   flutter run -d macos
   ```

## Demo Credentials

Use these credentials to log in:

| Field | Value |
|-------|-------|
| Email | `test@gmail.com` |
| Password | `Test@123` |

## API Reference

This app uses the [Open Trivia Database API](https://opentdb.com/api_config.php):

**Endpoint:**
```
GET https://opentdb.com/api.php?amount=10&category={category_id}&type=multiple
```

**Quiz Categories:**
| Category | API ID |
|----------|--------|
| General Knowledge | 9 |
| Science & Nature | 17 |
| Computers | 18 |
| Mathematics | 19 |
| Mythology | 20 |
| Sports | 21 |
| Geography | 22 |
| History | 23 |
| Art | 25 |
| Animals | 27 |

## Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/auth_repository_test.dart
```

## Project Structure Details

### State Management (Riverpod)

- `authProvider`: Manages authentication state
- `quizProvider`: Controls quiz flow (countdown, questions, timer, results)
- `userProvider`: Handles user data and category progress
- `rankingProvider`: Fetches and displays leaderboard

### Routing (GoRouter)

- `/login` - Authentication screen
- `/home` - Home tab (default after login)
- `/profile` - User profile tab
- `/ranking` - Leaderboard tab
- `/quiz/:categoryId` - Quiz gameplay screen
- `/result` - Quiz results screen

### Key Components

| Component | Purpose |
|-----------|---------|
| `MainScaffold` | Responsive tab navigation |
| `QuestionCard` | Displays quiz questions with options |
| `TimerBar` | Animated timer with color changes |
| `CountdownOverlay` | 3-2-1 countdown animation |
| `CategoryCard` | Category selection with progress |

## Design Decisions

1. **Riverpod over Provider/Bloc**: Chosen for its simplicity, testability, and built-in support for dependency injection.

2. **GetIt for Services**: While Riverpod handles state, GetIt manages singleton services like API clients and repositories.

3. **GoRouter with ShellRoute**: Enables persistent tab navigation while allowing quiz screens to hide the bottom navigation.

4. **Responsive Design**: Uses `LayoutBuilder` and breakpoints to adapt UI between mobile (bottom nav) and desktop (side rail).

5. **Mock Data for Rankings**: Rankings use local JSON to demonstrate API flow without requiring a backend.

## Optional Features Implemented

- Animations throughout the app (countdown, transitions, confetti)
- Error handling with retry functionality
- Loading states with progress indicators
- Responsive layouts for all screen sizes
- Progress tracking per category

## Known Limitations

- Session is stored in memory (clears on app restart)
- Rankings are mocked locally
- No offline support (requires network for quiz questions)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Acknowledgments

- [Open Trivia Database](https://opentdb.com/) for the quiz questions API
- [Flutter](https://flutter.dev/) for the amazing cross-platform framework
- [Riverpod](https://riverpod.dev/) for state management
- [GoRouter](https://pub.dev/packages/go_router) for declarative routing
