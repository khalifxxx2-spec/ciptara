import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'Challenge Global'),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: AppDummyData.challenges.length,
        itemBuilder: (context, index) {
          final challenge = AppDummyData.challenges[index];
          return _buildChallengeCard(challenge);
        },
      ),
    );
  }

  Widget _buildChallengeCard(dynamic challenge) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.network(
              challenge.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.cyan.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'AKTIF',
                        style: AppTextStyles.caption(color: AppColors.cyan, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.people_outline_rounded, size: 16, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          '${challenge.participants} Peserta',
                          style: AppTextStyles.caption(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  challenge.title,
                  style: AppTextStyles.heading(fontSize: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  challenge.description,
                  style: AppTextStyles.body(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.emoji_events_outlined, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      challenge.reward,
                      style: AppTextStyles.label(color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Deadline', style: AppTextStyles.caption()),
                          Text(
                            '15 Juni 2024', // Static for dummy
                            style: AppTextStyles.label(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyan,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Ikuti Challenge', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
