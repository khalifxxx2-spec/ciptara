import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/app_models.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class CollaborationWorkspacePage extends StatefulWidget {
  final CollaborationProject project;

  const CollaborationWorkspacePage({super.key, required this.project});

  @override
  State<CollaborationWorkspacePage> createState() => _CollaborationWorkspacePageState();
}

class _CollaborationWorkspacePageState extends State<CollaborationWorkspacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: GradientAppBar(
        title: widget.project.title,
        actions: [
          IconButton(icon: const Icon(Icons.videocam_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildProjectProgress(),
          _buildMemberRow(),
          Expanded(child: _buildChatArea()),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildProjectProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Project Progress', style: AppTextStyles.label(color: Colors.white)),
              Text('${(widget.project.progress * 100).toInt()}%', style: AppTextStyles.label(color: AppColors.cyan)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: widget.project.progress,
            backgroundColor: AppColors.surfaceLight,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberRow() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: widget.project.members.length,
        itemBuilder: (context, index) {
          final member = widget.project.members[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(member.profilePic),
              child: index == 0 ? const Align(alignment: Alignment.bottomRight, child: Icon(Icons.star, color: Colors.amber, size: 14)) : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatArea() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: widget.project.messages.length,
      itemBuilder: (context, index) {
        final msg = widget.project.messages[index];
        bool isMe = msg.senderId == '1';
        return _buildMessage(msg, isMe);
      },
    );
  }

  Widget _buildMessage(ProjectMessage msg, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.cyan.withValues(alpha: 0.1) : AppColors.cardDark,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isMe ? AppColors.cyan.withValues(alpha: 0.3) : AppColors.surfaceLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe) Text(msg.senderName, style: AppTextStyles.caption(color: AppColors.cyan, fontWeight: FontWeight.bold)),
            Text(msg.message, style: AppTextStyles.body(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      color: AppColors.navyBlue,
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.textMuted), onPressed: () {}),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: AppTextStyles.body(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.cardDark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.mic_none_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
