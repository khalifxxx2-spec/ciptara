import 'package:flutter/material.dart';

class Creator {
  final String id;
  final String name;
  final String username;
  final String profilePic;
  final String bio;
  final int followers;
  final int following;
  final int totalLikes;
  final int totalIdeas;
  final List<String> badges;
  final bool isVerified;
  final int level;
  final int xp;
  final int rank;
  final Map<String, String>? educationLinks;

  Creator({
    required this.id,
    required this.name,
    required this.username,
    required this.profilePic,
    required this.bio,
    required this.followers,
    required this.following,
    required this.totalLikes,
    required this.totalIdeas,
    this.badges = const [],
    this.isVerified = false,
    this.level = 1,
    this.xp = 0,
    this.rank = 0,
    this.educationLinks,
  });
}

class InnovationVideo {
  final String id;
  final String videoUrl;
  final String thumbnailUrl;
  final String title;
  final String description;
  final Creator creator;
  final int likes;
  final int comments;
  final int shares;
  final int saves;
  final List<String> hashtags;
  final String category;
  final DateTime createdAt;
  final double impactScore;

  InnovationVideo({
    required this.id,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.title,
    required this.description,
    required this.creator,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.saves,
    required this.hashtags,
    required this.category,
    required this.createdAt,
    this.impactScore = 0.0,
  });
}

class ProjectMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime time;
  final String? attachmentUrl;

  ProjectMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.time,
    this.attachmentUrl,
  });
}

class CollaborationProject {
  final String id;
  final String title;
  final String description;
  final List<Creator> members;
  final List<ProjectMessage> messages;
  final double progress;
  final DateTime createdAt;

  CollaborationProject({
    required this.id,
    required this.title,
    required this.description,
    required this.members,
    required this.messages,
    required this.progress,
    required this.createdAt,
  });
}

class InnovationBattle {
  final String id;
  final InnovationVideo idea1;
  final InnovationVideo idea2;
  int votes1;
  int votes2;
  final DateTime endTime;

  InnovationBattle({
    required this.id,
    required this.idea1,
    required this.idea2,
    required this.votes1,
    required this.votes2,
    required this.endTime,
  });
}

class InnovationChallenge {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int participants;
  final String reward;
  final DateTime deadline;
  final List<String> categories;

  InnovationChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.participants,
    required this.reward,
    required this.deadline,
    required this.categories,
  });
}

class SkillBadge {
  final String name;
  final String icon;
  final Color color;

  SkillBadge({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // like, comment, follow, invite, battle, achievement
  final DateTime time;
  final String? fromUser;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.time,
    this.fromUser,
    this.isRead = false,
  });
}

class AIMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  AIMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}
