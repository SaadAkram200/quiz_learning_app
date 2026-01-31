import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/user_avatar.dart';
import '../../widgets/stat_card.dart';

/// Profile screen showing user information
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final isMobile = context.isMobile;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.applyOpacity(0.1),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.contentMaxWidth,
                ),
                child: Column(
                  children: [
                    // Profile header
                    _buildProfileHeader(context, user),
                    32.vBox,

                    // Stats
                    _buildStats(context, user, isMobile),
                    32.vBox,

                    // Account info
                    _buildAccountInfo(context, user),
                    32.vBox,

                    // Logout button
                    _buildLogoutButton(context, ref),
                    24.vBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, user) {
    return Column(
      children: [
        Hero(
          tag: 'user_avatar',
          child: UserAvatar(
            imageUrl: user.avatarUrl,
            size: 120,
            showBorder: true,
            borderColor: AppColors.primary,
            borderWidth: 4,
          ),
        ),
        16.vBox,
        Text(
          user.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        4.vBox,
        Text(
          user.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        12.vBox,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 18,
              ),
              6.hBox,
              Text(
                'Rank #${user.rank}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context, user, bool isMobile) {
    final stats = [
      {
        'icon': Icons.star,
        'label': 'Total Score',
        'value': '${user.score}',
        'color': AppColors.warning,
      },
      {
        'icon': Icons.leaderboard,
        'label': 'Global Rank',
        'value': '#${user.rank}',
        'color': AppColors.primary,
      },
      {
        'icon': Icons.quiz,
        'label': 'Quizzes Taken',
        'value': '${(user.score / 50).floor()}',
        'color': AppColors.success,
      },
    ];

    if (isMobile) {
      return Column(
        children: stats
            .map((stat) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: StatCard(
                    icon: stat['icon'] as IconData,
                    label: stat['label'] as String,
                    value: stat['value'] as String,
                    color: stat['color'] as Color,
                  ),
                ))
            .toList(),
      );
    }

    return Row(
      children: stats
          .map((stat) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: StatCard(
                    icon: stat['icon'] as IconData,
                    label: stat['label'] as String,
                    value: stat['value'] as String,
                    color: stat['color'] as Color,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildAccountInfo(BuildContext context, user) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.textTertiary.applyOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            16.vBox,
            _buildInfoRow(
              context,
              Icons.person_outline,
              'Full Name',
              user.name,
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              Icons.email_outlined,
              'Email Address',
              user.email,
            ),
            const Divider(height: 24),
            _buildInfoRow(
              context,
              Icons.badge_outlined,
              'User ID',
              '#${user.id}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.applyOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        16.hBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              2.vBox,
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
          );

          if (confirm == true) {
            await ref.read(authProvider.notifier).logout();
            if (context.mounted) {
              context.go(AppRoutes.login);
            }
          }
        },
        icon: const Icon(Icons.logout, color: AppColors.error),
        label: const Text(
          'Logout',
          style: TextStyle(color: AppColors.error),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.error),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
