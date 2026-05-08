import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/idea_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: GradientAppBar(
        title: 'Profil',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.3), width: 1),
                ),
                child: const Icon(Icons.settings_outlined, color: AppColors.textSecondary, size: 20),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildProfileHeader()),
          SliverToBoxAdapter(child: _buildStatsRow()),
          SliverToBoxAdapter(child: _buildBioSection()),
          SliverToBoxAdapter(child: _buildMyIdeasHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => IdeaCard(idea: DummyData.myIdeas[index], isCompact: true),
                childCount: DummyData.myIdeas.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.deepBlue, AppColors.cardDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.2), width: 1),
        boxShadow: [BoxShadow(color: AppColors.purple.withValues(alpha: 0.15), blurRadius: 30, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 96, height: 96,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
                child: Container(
                  decoration: const BoxDecoration(color: AppColors.darkBlue, shape: BoxShape.circle),
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
                      child: Text('KR', style: AppTextStyles.display(fontSize: 30, letterSpacing: 0)),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2, right: 2,
                child: Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFF69F0AE), shape: BoxShape.circle,
                    border: Border.all(color: AppColors.darkBlue, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Khalif Rahmad Ramadhan', style: AppTextStyles.heading(fontSize: 20), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text('@khalif.rahmad', style: AppTextStyles.label(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.cyan)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.purple.withValues(alpha: 0.25), AppColors.cyan.withValues(alpha: 0.15)]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.purple.withValues(alpha: 0.4), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.school_outlined, size: 13, color: AppColors.purple),
                const SizedBox(width: 5),
                Text('Mahasiswa Inovator', style: AppTextStyles.label(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.purple)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                side: BorderSide(color: AppColors.cyan.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit_outlined, size: 16, color: AppColors.cyan),
                  const SizedBox(width: 8),
                  Text('Edit Profil', style: AppTextStyles.label(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.cyan)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          _buildStatCard('3', 'Ide Dibuat', Icons.lightbulb_rounded),
          const SizedBox(width: 12),
          _buildStatCard('342', 'Total Like', Icons.favorite_rounded),
          const SizedBox(width: 12),
          _buildStatCard('12', 'Pengikut', Icons.people_rounded),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.purple.withValues(alpha: 0.15), width: 1),
        ),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 6),
            Text(value, style: AppTextStyles.display(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 0)),
            Text(label, style: AppTextStyles.caption(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.textMuted), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildBioSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.12), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.cyan),
              const SizedBox(width: 8),
              Text('Tentang Saya', style: AppTextStyles.label(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Mahasiswa Teknik Informatika yang passionate di bidang teknologi, inovasi, dan kewirausahaan digital. Percaya bahwa ide besar lahir dari keberanian untuk bereksperimen. 🌟',
            style: AppTextStyles.body(fontSize: 13, height: 1.7),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: ['Flutter', 'UI/UX', 'Startup', 'AI'].map((tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.cyan.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.cyan.withValues(alpha: 0.2), width: 1),
              ),
              child: Text('#$tag', style: AppTextStyles.caption(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.cyan)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMyIdeasHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ide Saya', style: AppTextStyles.heading(fontSize: 20)),
          Text('${DummyData.myIdeas.length} ide dipublikasikan', style: AppTextStyles.caption()),
        ],
      ),
    );
  }
}
