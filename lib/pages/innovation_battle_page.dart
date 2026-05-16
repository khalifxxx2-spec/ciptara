import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../data/dummy_data.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class InnovationBattlePage extends StatefulWidget {
  const InnovationBattlePage({super.key});

  @override
  State<InnovationBattlePage> createState() => _InnovationBattlePageState();
}

class _InnovationBattlePageState extends State<InnovationBattlePage> {
  final battle = AppDummyData.battles[0];
  int selectedIdea = 0; // 0 for none, 1 for idea1, 2 for idea2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'Innovation Battle'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildBattleHeader(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIdeaCard(battle.idea1, 1),
                _buildVSLabel(),
                _buildIdeaCard(battle.idea2, 2),
              ],
            ),
            const SizedBox(height: 40),
            _buildVotingSection(),
            const SizedBox(height: 30),
            _buildCommentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBattleHeader() {
    return Column(
      children: [
        Text(
          'ADU SOLUSI TERBAIK',
          style: AppTextStyles.display(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer_outlined, color: Colors.red, size: 14),
              const SizedBox(width: 6),
              Text('BERAKHIR DALAM 14 JAM', style: AppTextStyles.caption(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIdeaCard(InnovationVideo idea, int index) {
    bool isSelected = selectedIdea == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIdea = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.cyan : AppColors.surfaceLight,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected ? [BoxShadow(color: AppColors.cyan.withValues(alpha: 0.3), blurRadius: 15)] : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Column(
            children: [
              Image.network(idea.thumbnailUrl, height: 200, fit: BoxFit.cover),
              Container(
                padding: const EdgeInsets.all(12),
                color: AppColors.cardDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(idea.title, style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(idea.creator.username, style: AppTextStyles.caption(fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVSLabel() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [BoxShadow(color: AppColors.purple.withValues(alpha: 0.5), blurRadius: 10)],
      ),
      child: const Text('VS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
    );
  }

  void _onVote() {
    if (selectedIdea == 0) return;
    
    setState(() {
      if (selectedIdea == 1) {
        battle.votes1++;
      } else {
        battle.votes2++;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Votemu untuk Ide $selectedIdea telah dicatat! 🗳️'),
        backgroundColor: AppColors.cyan,
      ),
    );
  }

  Widget _buildVotingSection() {
    int total = battle.votes1 + battle.votes2;
    double p1 = battle.votes1 / total;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(p1 * 100).toInt()}%', style: AppTextStyles.heading(color: AppColors.purple)),
              Text('${((1 - p1) * 100).toInt()}%', style: AppTextStyles.heading(color: AppColors.cyan)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: p1,
              minHeight: 12,
              backgroundColor: AppColors.cyan,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.purple),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: selectedIdea == 0 ? null : _onVote,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cyan,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('VOTE SOLUSI INI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Debat Inovasi (42)', style: AppTextStyles.heading(fontSize: 18)),
          const SizedBox(height: 20),
          _buildCommentItem('Khalif', 'Ide 1 lebih efisien karena menggunakan AI model terbaru.'),
          _buildCommentItem('Salsa', 'Tapi ide 2 lebih murah untuk diproduksi massal.'),
        ],
      ),
    );
  }

  Widget _buildCommentItem(String name, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=$name')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(text, style: AppTextStyles.body(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
