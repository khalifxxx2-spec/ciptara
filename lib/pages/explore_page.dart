import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';
import 'innovation_battle_page.dart';
import 'leaderboard_page.dart';
import 'ai_assistant_page.dart';
import 'video_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> categories = ['Teknologi', 'Pendidikan', 'Lingkungan', 'Sosial', 'Kesehatan'];
  String selectedCategory = 'Teknologi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: GradientAppBar(
        title: 'Eksplorasi Ide',
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome_rounded, color: AppColors.cyan),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AIAssistantPage()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Features Row (Battle & Leaderboard)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  Expanded(child: _buildFeatureCard('Innovation Battle', Icons.bolt, Colors.orangeAccent, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InnovationBattlePage()));
                  })),
                  const SizedBox(width: 16),
                  Expanded(child: _buildFeatureCard('Leaderboard', Icons.emoji_events_rounded, Colors.amber, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaderboardPage()));
                  })),
                ],
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildSearchBar(),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (val) => setState(() => selectedCategory = cat),
                      backgroundColor: AppColors.cardDark,
                      selectedColor: AppColors.cyan.withValues(alpha: 0.2),
                      labelStyle: AppTextStyles.label(color: isSelected ? AppColors.cyan : AppColors.textSecondary, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: isSelected ? AppColors.cyan : AppColors.surfaceLight, width: 1)),
                    ),
                  );
                },
              ),
            ),
          ),

          // Trending Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text('Tren Inovasi 🔥', style: AppTextStyles.heading(fontSize: 20)),
            ),
          ),

          // Innovation Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final video = AppDummyData.innovationVideos[index % AppDummyData.innovationVideos.length];
                  return _buildInnovationCard(video);
                },
                childCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(title, style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return GlassmorphicContainer(
      width: double.infinity, height: 55, borderRadius: 16, blur: 20, alignment: Alignment.center, border: 2,
      linearGradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.surfaceLight.withValues(alpha: 0.1), AppColors.surfaceLight.withValues(alpha: 0.05)]),
      borderGradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.cyan, AppColors.purple]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: AppColors.textMuted),
            const SizedBox(width: 12),
            Text('Cari ide, kreator, atau challenge...', style: AppTextStyles.body(color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _buildInnovationCard(dynamic video) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoDetailPage(video: video)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: NetworkImage(video.thumbnailUrl), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(video.title, style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CircleAvatar(radius: 8, backgroundImage: NetworkImage(video.creator.profilePic)),
                      const SizedBox(width: 6),
                      Expanded(child: Text(video.creator.username, style: AppTextStyles.caption(color: AppColors.textSecondary, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
