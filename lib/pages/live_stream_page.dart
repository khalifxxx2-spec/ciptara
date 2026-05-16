import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../theme/app_theme.dart';

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({super.key});

  @override
  State<LiveStreamPage> createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  final List<String> _comments = [
    'Wow, ide yang sangat keren! 🔥',
    'Bagaimana cara kerja sensornya?',
    'Siap kolaborasi! 🙌',
    'Kapan rilis aplikasinya?',
    'Semangat terus inovator muda! 🚀',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Placeholder (Video Stream)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/1080/1920?random=50'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),

          // Header (User Info & Live Badge)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildLiveUserInfo(),
                  const Spacer(),
                  _buildLiveBadge(),
                ],
              ),
            ),
          ),

          // Floating Comments
          Positioned(
            left: 16,
            bottom: 100,
            width: MediaQuery.of(context).size.width * 0.6,
            height: 300,
            child: _buildFloatingComments(),
          ),

          // Bottom Actions
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActions(),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveUserInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 15, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=1')),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Khalif Inov', style: AppTextStyles.label(color: Colors.white, fontWeight: FontWeight.bold)),
              Text('1.2K Penonton', style: AppTextStyles.caption(color: Colors.white, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildFloatingComments() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _comments.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'User$index: ', style: const TextStyle(color: AppColors.cyan, fontWeight: FontWeight.bold, fontSize: 13)),
                  TextSpan(text: _comments[index], style: const TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Tulis komentar...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildActionButton(Icons.emoji_emotions_outlined),
          const SizedBox(width: 12),
          _buildActionButton(Icons.share_outlined),
          const SizedBox(width: 12),
          _buildActionButton(Icons.favorite_outline_rounded, color: Colors.pinkAccent),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, {Color color = Colors.white}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
