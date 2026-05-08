import 'package:flutter/material.dart';
import '../models/idea_model.dart';
import '../theme/app_theme.dart';

class IdeaCard extends StatefulWidget {
  final IdeaModel idea;
  final bool isCompact;

  const IdeaCard({
    super.key,
    required this.idea,
    this.isCompact = false,
  });

  @override
  State<IdeaCard> createState() => _IdeaCardState();
}

class _IdeaCardState extends State<IdeaCard>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() => _isLiked = !_isLiked);
    _animController.forward().then((_) => _animController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          splashColor: AppColors.cyan.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Badge + Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryBadge(widget.idea.category),
                    Text(
                      widget.idea.timeAgo,
                      style: AppTextStyles.caption(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  widget.idea.title,
                  style: AppTextStyles.heading(
                    fontSize: widget.isCompact ? 15 : 17,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                if (!widget.isCompact) ...[
                  Text(
                    widget.idea.description,
                    style: AppTextStyles.body(fontSize: 13, height: 1.6),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                ],

                // Divider
                Container(height: 1, color: AppColors.surfaceLight),
                const SizedBox(height: 12),

                // Creator info + Like button
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          widget.idea.creatorInitials,
                          style: AppTextStyles.label(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.idea.creatorName,
                        style: AppTextStyles.label(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    // Like button
                    GestureDetector(
                      onTap: _toggleLike,
                      child: Row(
                        children: [
                          AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) => Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Icon(
                                _isLiked
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 18,
                                color: _isLiked
                                    ? Colors.pinkAccent
                                    : AppColors.textMuted,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.idea.likes + (_isLiked ? 1 : 0)}',
                            style: AppTextStyles.label(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _isLiked
                                  ? Colors.pinkAccent
                                  : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String category) {
    final Map<String, Color> categoryColors = {
      'Teknologi': AppColors.cyan,
      'Sosial': const Color(0xFFFF8A65),
      'Lingkungan': const Color(0xFF69F0AE),
      'Pendidikan': AppColors.purple,
      'Bisnis': const Color(0xFFFFD740),
    };

    final color = categoryColors[category] ?? AppColors.cyan;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        category,
        style: AppTextStyles.caption(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
