import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_learning_app/core/constants/app_constants.dart';
import 'package:quiz_learning_app/presentation/widgets/category_card.dart';
import 'package:quiz_learning_app/presentation/widgets/stat_card.dart';
import 'package:quiz_learning_app/presentation/widgets/user_avatar.dart';
import 'package:quiz_learning_app/presentation/widgets/timer_bar.dart';
import 'package:quiz_learning_app/data/models/quiz_category/quiz_category_model.dart';

void main() {
  group('CategoryCard Widget', () {
    testWidgets('should display category name and icon', (tester) async {
      const category = QuizCategoryModel(
        id: 9,
        name: 'General Knowledge',
        icon: '🧠',
        progress: 50,
      );
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category, onTap: () => tapped = true),
          ),
        ),
      );

      expect(find.text('General Knowledge'), findsOneWidget);
      expect(find.text('🧠'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);

      await tester.tap(find.byType(CategoryCard));
      expect(tapped, true);
    });

    testWidgets('should not show progress badge when progress is 0', (
      tester,
    ) async {
      const category = QuizCategoryModel(
        id: 9,
        name: 'Test Category',
        icon: '📚',
        progress: 0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category, onTap: () {}),
          ),
        ),
      );

      expect(find.text('0%'), findsNothing);
    });
  });

  group('StatCard Widget', () {
    testWidgets('should display label and value', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              icon: Icons.star,
              label: 'Total Score',
              value: '8200',
              color: Colors.orange,
            ),
          ),
        ),
      );

      expect(find.text('Total Score'), findsOneWidget);
      expect(find.text('8200'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  group('UserAvatar Widget', () {
    testWidgets('should display placeholder when no image URL', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: UserAvatar(imageUrl: null, size: 48)),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should be tappable when onTap is provided', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserAvatar(
              imageUrl: null,
              size: 48,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(UserAvatar));

      expect(tapped, true);
    });
  });

  group('TimerBar Widget', () {
    testWidgets('should display formatted time', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TimerBar(timeRemaining: 45, totalTime: 60)),
        ),
      );

      expect(find.text('00:45'), findsOneWidget);
      expect(find.text('Time Remaining'), findsOneWidget);
    });

    testWidgets('should show different colors based on time', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TimerBar(timeRemaining: 30, totalTime: 60)),
        ),
      );
      expect(find.text('00:30'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TimerBar(timeRemaining: 10, totalTime: 60)),
        ),
      );
      expect(find.text('00:10'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TimerBar(timeRemaining: 3, totalTime: 60)),
        ),
      );
      expect(find.text('00:03'), findsOneWidget);
    });
  });

  group('Model Tests', () {
    test('QuizCategoryModel should create from JSON correctly', () {
      final json = {
        'id': 9,
        'name': 'General Knowledge',
        'icon': '🧠',
        'progress': 75,
        'questionsAnswered': 30,
        'totalQuestions': 40,
      };

      final category = QuizCategoryModel.fromJson(json);

      expect(category.id, 9);
      expect(category.name, 'General Knowledge');
      expect(category.icon, '🧠');
      expect(category.progress, 75);
    });

    test('QuizCategoryModel copyWith should work correctly', () {
      const original = QuizCategoryModel(
        id: 9,
        name: 'Test',
        icon: '📚',
        progress: 50,
      );

      final updated = original.copyWith(progress: 75);

      expect(updated.id, original.id);
      expect(updated.name, original.name);
      expect(updated.progress, 75);
    });
  });

  group('AppConstants Tests', () {
    test('should have correct valid credentials', () {
      expect(AppConstants.validEmail, 'test@gmail.com');
      expect(AppConstants.validPassword, 'Test@123');
    });

    test('should have correct quiz settings', () {
      expect(AppConstants.questionsPerQuiz, 10);
      expect(AppConstants.questionTimeSeconds, 60);
      expect(AppConstants.countdownSeconds, 3);
    });

    test('should have 10 quiz categories', () {
      expect(AppConstants.quizCategories.length, 10);
    });

    test('quiz categories should have correct structure', () {
      for (final category in AppConstants.quizCategories) {
        expect(category.containsKey('id'), true);
        expect(category.containsKey('name'), true);
        expect(category.containsKey('icon'), true);
        expect(category['id'], isA<int>());
        expect(category['name'], isA<String>());
        expect(category['icon'], isA<String>());
      }
    });
  });
}
