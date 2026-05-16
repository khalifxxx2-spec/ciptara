import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sort creators by XP for leaderboard
    final topCreators = [...AppDummyData.creators]..sort((a, b) => b.xp.compareTo(a.xp));

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'Smart Innovation Ranking'),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildPodium(topCreators.take(3).toList()),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: topCreators.length,
                itemBuilder: (context, index) {
                  final creator = topCreators[index];
                  return _buildLeaderboardItem(creator, index + 1);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodium(List<Creator> top3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildPodiumItem(top3[1], 2, 120),
        _buildPodiumItem(top3[0], 1, 160),
        _buildPodiumItem(top3[2], 3, 120),
      ],
    );
  }

  Widget _buildPodiumItem(Creator creator, int rank, double height) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: rank == 1 ? AppColors.primaryGradient : null,
                color: rank == 1 ? null : AppColors.surfaceLight,
              ),
              child: CircleAvatar(radius: rank == 1 ? 40 : 30, backgroundImage: NetworkImage(creator.profilePic)),
            ),
            if (rank == 1)
              const Positioned(top: -15, child: Icon(Icons.emoji_events_rounded, color: Colors.amber, size: 30)),
          ],
        ),
        const SizedBox(height: 12),
        Text(creator.name, style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                rank == 1 ? AppColors.cyan.withValues(alpha: 0.3) : AppColors.surfaceLight.withValues(alpha: 0.2),
                Colors.transparent,
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Center(
            child: Text('#$rank', style: AppTextStyles.display(fontSize: 24, color: rank == 1 ? AppColors.cyan : AppColors.textMuted)),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(Creator creator, int rank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.navyBlue.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight, width: 0.5),
      ),
      child: Row(
        children: [
          SizedBox(width: 30, child: Text(rank.toString(), style: AppTextStyles.heading(fontSize: 16, color: AppColors.textMuted))),
          CircleAvatar(radius: 20, backgroundImage: NetworkImage(creator.profilePic)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(creator.name, style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('${creator.xp} XP', style: AppTextStyles.caption(color: AppColors.cyan)),
              ],
            ),
          ),
          _buildBadge(creator.badges.first),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
      ),
      child: Text(label, style: AppTextStyles.caption(color: AppColors.purple, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
