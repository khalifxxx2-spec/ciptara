import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';
import 'collaboration_workspace_page.dart';

class CollaborationPage extends StatefulWidget {
  const CollaborationPage({super.key});

  @override
  State<CollaborationPage> createState() => _CollaborationPageState();
}

class _CollaborationPageState extends State<CollaborationPage> {
  String selectedSkill = 'Programmer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'CiptaMatch & Workspace'),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Active Projects Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Active Projects', style: AppTextStyles.heading(fontSize: 18)),
                  const SizedBox(height: 16),
                  _buildActiveProjectCard(AppDummyData.collaborationProjects[0]),
                ],
              ),
            ),
          ),

          // Skill Selector
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Temukan Kolaborator', style: AppTextStyles.heading(fontSize: 18)),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: AppDummyData.collaborationSkills.length,
                    itemBuilder: (context, index) {
                      final skill = AppDummyData.collaborationSkills[index];
                      final isSelected = selectedSkill == skill['name'];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () => setState(() => selectedSkill = skill['name']),
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 60, height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected ? skill['color'].withValues(alpha: 0.2) : AppColors.cardDark,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: isSelected ? skill['color'] : AppColors.surfaceLight, width: 2),
                                ),
                                child: Icon(skill['icon'], color: isSelected ? skill['color'] : AppColors.textMuted),
                              ),
                              const SizedBox(height: 8),
                              Text(skill['name'], style: AppTextStyles.caption(color: isSelected ? Colors.white : AppColors.textMuted, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Recommendations
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text('Rekomendasi Match', style: AppTextStyles.heading(fontSize: 18)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final creator = AppDummyData.creators[index % AppDummyData.creators.length];
                  return _buildMatchCard(creator);
                },
                childCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveProjectCard(CollaborationProject project) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CollaborationWorkspacePage(project: project)));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3), width: 1),
          boxShadow: [BoxShadow(color: AppColors.cyan.withValues(alpha: 0.1), blurRadius: 10)],
        ),
        child: Row(
          children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(color: AppColors.cyan.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.rocket_launch_rounded, color: AppColors.cyan, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title, style: AppTextStyles.heading(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('${project.members.length} Members • ${(project.progress * 100).toInt()}% Done', style: AppTextStyles.caption()),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textMuted, size: 16),
          ],
        ),
      ),
    );
  }

  void _onInvite(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Undangan kolaborasi dikirim ke $name! ✉️'),
        backgroundColor: AppColors.purple,
        action: SnackBarAction(label: 'Batal', textColor: Colors.white, onPressed: () {}),
      ),
    );
  }

  Widget _buildMatchCard(Creator creator) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(creator.profilePic)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(creator.name, style: AppTextStyles.heading(fontSize: 16)),
                    if (creator.isVerified) ...[const SizedBox(width: 4), const Icon(Icons.verified_rounded, size: 16, color: AppColors.cyan)],
                  ],
                ),
                Text(creator.username, style: AppTextStyles.caption()),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: creator.badges.take(2).map<Widget>((badge) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.purple.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(badge, style: AppTextStyles.caption(color: AppColors.purple, fontSize: 10, fontWeight: FontWeight.bold)),
                  )).toList(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _onInvite(creator.name),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyan, foregroundColor: Colors.black, minimumSize: const Size(60, 30), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: const Text('Invite', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
