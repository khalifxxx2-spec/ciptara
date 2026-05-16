import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import 'analytics_dashboard_page.dart';
import 'video_detail_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppDummyData.creators[0]; // Current user dummy

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: AppColors.darkBlue,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(user, context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.analytics_outlined, color: AppColors.cyan),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalyticsDashboardPage()));
                },
              ),
              IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
            ],
          ),

          // Level & XP System
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buildLevelCard(user),
            ),
          ),

          // Stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('Ide', user.totalIdeas.toString()),
                  _buildStatItem('Views', '2.4M'),
                  _buildStatItem('Likes', '45K'),
                  _buildStatItem('Rank', '#${user.rank}'),
                ],
              ),
            ),
          ),

          // Education Links
          if (user.educationLinks != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildEducationLinks(user.educationLinks!),
              ),
            ),

          // Achievements
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Achievements', style: AppTextStyles.heading(fontSize: 18)),
                  const SizedBox(height: 16),
                  _buildAchievementRow(),
                ],
              ),
            ),
          ),

          // Tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                labelColor: AppColors.cyan,
                unselectedLabelColor: AppColors.textMuted,
                indicatorColor: AppColors.cyan,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(icon: Icon(Icons.grid_view_rounded)),
                  Tab(icon: Icon(Icons.favorite_border_rounded)),
                  Tab(icon: Icon(Icons.bookmark_border_rounded)),
                ],
              ),
            ),
          ),

          // Grid of Videos
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(2, 2, 2, 100),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final video = AppDummyData.innovationVideos[index % AppDummyData.innovationVideos.length];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VideoDetailPage(video: video)),
                      );
                    },
                    child: Container(
                      color: AppColors.cardDark,
                      child: Stack(
                        children: [
                          Image.network(
                            video.thumbnailUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: Row(
                              children: [
                                const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 14),
                                Text('${(video.likes / 100).toStringAsFixed(1)}K', style: const TextStyle(color: Colors.white, fontSize: 10)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(dynamic user, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.purple.withValues(alpha: 0.2), AppColors.darkBlue],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(user.profilePic),
                  backgroundColor: AppColors.navyBlue,
                ),
              ),
              if (user.isVerified)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.cyan,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified_rounded, color: Colors.black, size: 20),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(user.name, style: AppTextStyles.display(fontSize: 26, fontWeight: FontWeight.bold)),
          Text(user.username, style: AppTextStyles.body(color: AppColors.cyan, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(user.bio, textAlign: TextAlign.center, style: AppTextStyles.body(color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileButton('Edit Profil', isPrimary: true),
              const SizedBox(width: 12),
              _buildProfileButton('Bagikan'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(dynamic user) {
    double progress = (user.xp % 1000) / 1000;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: Colors.amber, size: 20),
                  const SizedBox(width: 8),
                  Text('Level ${user.level} Innovator', style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              Text('${user.xp % 1000} / 1000 XP', style: AppTextStyles.caption(color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.surfaceLight,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationLinks(Map<String, String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform Edukasi', style: AppTextStyles.heading(fontSize: 18)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: links.entries.map((entry) {
            IconData icon;
            Color color;
            switch (entry.key.toLowerCase()) {
              case 'linkedin':
                icon = FontAwesomeIcons.linkedin;
                color = const Color(0xFF0A66C2);
                break;
              case 'github':
                icon = FontAwesomeIcons.github;
                color = Colors.white;
                break;
              case 'coursera':
                icon = Icons.school_rounded;
                color = const Color(0xFF0056D2);
                break;
              default:
                icon = Icons.link_rounded;
                color = AppColors.cyan;
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color, size: 16),
                  const SizedBox(width: 8),
                  Text(entry.key, style: AppTextStyles.label(color: Colors.white, fontSize: 12)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAchievementRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildAchievementIcon(Icons.auto_awesome, 'Future Creator', Colors.cyan),
          _buildAchievementIcon(Icons.eco_rounded, 'Green Innovator', Colors.green),
          _buildAchievementIcon(Icons.code_rounded, 'Stack Builder', Colors.blue),
          _buildAchievementIcon(Icons.public_rounded, 'Global Thinker', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildAchievementIcon(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.caption(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.heading(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: AppTextStyles.caption()),
      ],
    );
  }

  Widget _buildProfileButton(String label, {bool isPrimary = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: isPrimary ? Colors.white : AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary ? null : Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Text(label, style: AppTextStyles.label(color: isPrimary ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: AppColors.darkBlue, child: _tabBar);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
