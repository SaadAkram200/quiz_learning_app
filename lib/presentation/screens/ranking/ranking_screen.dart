import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helper_extensions/extensions/color_utilities.dart';
import 'package:helper_extensions/extensions/widget_utilities.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../providers/auth_provider.dart';
import '../../providers/ranking_provider.dart';
import '../../widgets/user_avatar.dart';

// Ranking screen showing leaderboard
class RankingScreen extends ConsumerWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankedUsersAsync = ref.watch(rankedUsersProvider);
    final currentUser = ref.watch(currentUserProvider);
    final isMobile = context.isMobile;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.applyOpacity(0.05),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: header(context, isMobile),
              ),

              // Top 3 
              rankedUsersAsync.when(
                data: (users) => SliverToBoxAdapter(
                  child: podium(context, users.take(3).toList(), isMobile),
                ),
                loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
                error: (_, _) => const SliverToBoxAdapter(child: SizedBox.shrink()),
              ),

              // Ranking list
              rankedUsersAsync.when(
                data: (users) => rankingList(
                  context,
                  users,
                  currentUser?.id,
                  isMobile,
                ),
                loading: () => const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
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
                          'Failed to load rankings',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        8.vBox,
                        ElevatedButton(
                          onPressed: () => ref.invalidate(rankedUsersProvider),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom padding
              SliverToBoxAdapter(
                child: 24.vBox,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.leaderboard,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              16.hBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Leaderboard',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'See how you rank among others',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget podium(BuildContext context, List users, bool isMobile) {
    if (users.length < 3) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd place
          podiumItem(context, users[1], 2, isMobile),
          // 1st place
          podiumItem(context, users[0], 1, isMobile),
          // 3rd place
          podiumItem(context, users[2], 3, isMobile),
        ],
      ),
    );
  }

  Widget podiumItem(
    BuildContext context,
    dynamic user,
    int position,
    bool isMobile,
  ) {
    final colors = {
      1: AppColors.gold,
      2: AppColors.silver,
      3: AppColors.bronze,
    };

    final heights = {
      1: 120.0,
      2: 90.0,
      3: 70.0,
    };

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            UserAvatar(
              imageUrl: user.avatarUrl,
              size: isMobile ? 56 : 72,
              showBorder: true,
              borderColor: colors[position]!,
              borderWidth: 3,
            ),
            Positioned(
              bottom: -8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colors[position],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colors[position]!.applyOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '$position',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        16.vBox,
        Text(
          user.name.split(' ').first,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '${user.score} pts',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        8.vBox,
        Container(
          width: isMobile ? 80 : 100,
          height: heights[position],
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors[position]!,
                colors[position]!.applyOpacity(0.7),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.emoji_events,
              color: Colors.white.applyOpacity(0.5),
              size: 32,
            ),
          ),
        ),
      ],
    );
  }

  Widget rankingList(
    BuildContext context,
    List users,
    String? currentUserId,
    bool isMobile,
  ) {
    return SliverPadding(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final user = users[index];
            final isCurrentUser = user.id == currentUserId;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RankingTile(
                user: user,
                isCurrentUser: isCurrentUser,
              ),
            );
          },
          childCount: users.length,
        ),
      ),
    );
  }
}

class RankingTile extends StatelessWidget {
  final dynamic user;
  final bool isCurrentUser;

  const RankingTile({super.key, 
    required this.user,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? AppColors.primary.applyOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentUser
              ? AppColors.primary
              : AppColors.textTertiary.applyOpacity(0.2),
          width: isCurrentUser ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isCurrentUser
                ? AppColors.primary.applyOpacity(0.1)
                : Colors.black.applyOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: getRankColor(user.rank).applyOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '#${user.rank}',
                style: TextStyle(
                  color: getRankColor(user.rank),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          12.hBox,

          // Avatar
          UserAvatar(
            imageUrl: user.avatarUrl,
            size: 48,
          ),
          12.hBox,

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        user.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      8.hBox,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'You',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                2.vBox,
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Score
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${user.score}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
              Text(
                'points',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color getRankColor(int rank) {
    switch (rank) {
      case 1:
        return AppColors.gold;
      case 2:
        return AppColors.silver;
      case 3:
        return AppColors.bronze;
      default:
        return AppColors.primary;
    }
  }
}
