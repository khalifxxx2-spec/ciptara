import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../widgets/innovation_video_player.dart';
import '../theme/app_theme.dart';

class VideoDetailPage extends StatelessWidget {
  final InnovationVideo video;

  const VideoDetailPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: InnovationVideoPlayer(
        video: video,
        isActive: true,
      ),
    );
  }
}
