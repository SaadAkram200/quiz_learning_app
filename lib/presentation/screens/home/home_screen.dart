import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user_avatar.dart';
import '../../widgets/category_card.dart';

// Home screen with categories list
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final isMobile = context.isMobile;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary.applyOpacity(0.05), AppColors.background],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(child: header(context, user, isMobile)),

              // Welcome message
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 32,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose a Category',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.vBox,
                      Text(
                        'Test your knowledge in various topics',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories grid
              categoriesAsync.when(
                data: (categories) =>
                    categoriesGrid(context, categories, isMobile),
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: AppColors.error,
                        ),
                        16.vBox,
                        Text(
                          'Failed to load categories',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        8.vBox,
                        ElevatedButton(
                          onPressed: () => ref.invalidate(categoriesProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom padding
              SliverToBoxAdapter(child: 24.vBox),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context, user, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.applyOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              UserAvatar(
                imageUrl: user?.avatarUrl,
                size: isMobile ? 56 : 64,
                showBorder: true,
                borderColor: Colors.white,
                borderWidth: 2,
              ),
              16.hBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${user?.name.split(' ').first ?? 'Quiz Master'}!',
                      style: TextStyle(
                        color: Colors.white.applyOpacity(0.9),
                        fontSize: isMobile ? 14 : 16,
                      ),
                    ),
                    4.vBox,
                    Text(
                      'Ready to challenge yourself?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.vBox,
          Row(
            children: [
              statBadge(context, Icons.star, '${user?.score ?? 0}', 'Score'),
              12.hBox,
              statBadge(
                context,
                Icons.emoji_events,
                '#${user?.rank ?? '-'}',
                'Rank',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget statBadge(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.applyOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            12.hBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.applyOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget categoriesGrid(BuildContext context, List categories, bool isMobile) {
    final columns = ResponsiveHelper.getGridColumns(context);
    final padding = isMobile ? 20.0 : 32.0;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: isMobile ? 1.8 : 2.0,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final category = categories[index];
          return CategoryCard(
            category: category,
            onTap: () {
              context.push(
                '${AppRoutes.quizWithId(category.id)}?name=${Uri.encodeComponent(category.name)}',
              );
            },
          );
        }, childCount: categories.length),
      ),
    );
  }
}
