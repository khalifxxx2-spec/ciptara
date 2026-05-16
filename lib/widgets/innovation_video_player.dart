import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';

class InnovationVideoPlayer extends StatefulWidget {
  final InnovationVideo video;
  final bool isActive;

  const InnovationVideoPlayer({
    super.key,
    required this.video,
    required this.isActive,
  });

  @override
  State<InnovationVideoPlayer> createState() => _InnovationVideoPlayerState();
}

class _InnovationVideoPlayerState extends State<InnovationVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
          _controller.setVolume(1.0); // Pastikan suara aktif
          _controller.setLooping(true);
          if (widget.isActive) {
            _controller.play();
          }
        }
      }).catchError((error) {
        debugPrint("Video Error: $error");
      });
  }

  @override
  void didUpdateWidget(InnovationVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isInitialized) {
      if (widget.isActive && !oldWidget.isActive) {
        _controller.play();
      } else if (!widget.isActive && oldWidget.isActive) {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() => setState(() => _isLiked = !_isLiked);
  void _toggleSave() => setState(() => _isSaved = !_isSaved);

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.video.id),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.5) {
          if (_isInitialized && widget.isActive) _controller.play();
        } else {
          if (_isInitialized) _controller.pause();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video Layer
          _buildVideoLayer(),

          // UI Overlays
          _buildGradientOverlay(),
          _buildSidebar(),
          _buildVideoInfo(),
          
          // Play/Pause Center Indicator
          if (_isInitialized && !_controller.value.isPlaying)
            IgnorePointer(
              child: Center(
                child: Icon(Icons.play_arrow_rounded, size: 80, color: Colors.white.withValues(alpha: 0.5)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoLayer() {
    return GestureDetector(
      onTap: () {
        if (_isInitialized) {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        }
      },
      child: Container(
        color: Colors.black,
        child: _isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            : Stack(
                children: [
                  Image.network(widget.video.thumbnailUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                  const Center(child: CircularProgressIndicator(color: AppColors.cyan)),
                ],
              ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent, Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.2, 0.6, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Positioned(
      right: 16,
      bottom: 20,
      child: Column(
        children: [
          _buildCreatorAvatar(),
          const SizedBox(height: 25),
          _buildSidebarIcon(
            onTap: _toggleLike,
            icon: _isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            label: (_isLiked ? widget.video.likes + 1 : widget.video.likes).toString(),
            color: _isLiked ? Colors.redAccent : Colors.white,
          ),
          const SizedBox(height: 20),
          _buildSidebarIcon(icon: FontAwesomeIcons.solidComment, label: widget.video.comments.toString()),
          const SizedBox(height: 20),
          _buildSidebarIcon(
            onTap: _toggleSave,
            icon: _isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
            label: (_isSaved ? widget.video.saves + 1 : widget.video.saves).toString(),
            color: _isSaved ? AppColors.cyan : Colors.white,
          ),
          const SizedBox(height: 20),
          _buildSidebarIcon(icon: FontAwesomeIcons.share, label: widget.video.shares.toString()),
        ],
      ),
    );
  }

  Widget _buildCreatorAvatar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50, height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            image: DecorationImage(image: NetworkImage(widget.video.creator.profilePic), fit: BoxFit.cover),
          ),
        ),
        Positioned(bottom: -8, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: const Icon(Icons.add, color: Colors.white, size: 14))),
      ],
    );
  }

  Widget _buildSidebarIcon({required IconData icon, required String label, Color? color, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color ?? Colors.white, size: 30),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.caption(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Positioned(
      left: 16, bottom: 20, right: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.video.creator.username, style: AppTextStyles.heading(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(widget.video.description, style: AppTextStyles.body(fontSize: 15, color: Colors.white.withValues(alpha: 0.9)), maxLines: 3, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          Row(
            children: widget.video.hashtags.map((tag) => Padding(padding: const EdgeInsets.only(right: 8), child: Text(tag, style: AppTextStyles.body(fontSize: 14, color: AppColors.cyan, fontWeight: FontWeight.bold)))).toList(),
          ),
        ],
      ),
    );
  }
}
