import 'package:flutter/material.dart';
import '../models/app_models.dart';

class AppDummyData {
  static final List<Creator> creators = [
    Creator(
      id: '1',
      name: 'Khalif Inovator',
      username: '@khalif_inov',
      profilePic: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
      bio: 'Mahasiswa UI. Fokus pada AI & Teknologi Hijau. Membangun masa depan.',
      followers: 12500,
      following: 120,
      totalLikes: 45000,
      totalIdeas: 12,
      badges: ['Innovator', 'Pioneer', 'Top 1%'],
      isVerified: true,
      level: 15,
      xp: 4500,
      rank: 3,
      educationLinks: {
        'LinkedIn': 'linkedin.com/in/khalif',
        'GitHub': 'github.com/khalif',
        'Coursera': 'coursera.org/user/khalif',
      },
    ),
    Creator(
      id: '2',
      name: 'Salsa Desain',
      username: '@salsa_tech',
      profilePic: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
      bio: 'Antusias UI/UX. Mendesain untuk dampak sosial.',
      followers: 8900,
      following: 450,
      totalLikes: 32000,
      totalIdeas: 8,
      badges: ['Designer', 'Rising Star'],
      isVerified: true,
      level: 12,
      xp: 3200,
      rank: 8,
    ),
    Creator(
      id: '3',
      name: 'Andi Koding',
      username: '@andi_creator',
      profilePic: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
      bio: 'Fullstack Dev & kontributor Open Source.',
      followers: 5600,
      following: 200,
      totalLikes: 15000,
      totalIdeas: 5,
      badges: ['Coder'],
      level: 10,
      xp: 2100,
      rank: 15,
    ),
  ];

  static final List<InnovationVideo> innovationVideos = [
    InnovationVideo(
      id: 'v1',
      videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-sorting-plastic-bottles-for-recycling-43936-large.mp4',
      thumbnailUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?q=80&w=800&auto=format&fit=crop',
      title: 'Tempat Sampah Pintar AI',
      description: 'Tempat sampah pintar yang menggunakan AI untuk memilah sampah secara otomatis. Membantu kota mengelola sampah lebih efisien.',
      creator: creators[0],
      likes: 1200,
      comments: 45,
      shares: 89,
      saves: 156,
      hashtags: ['#SmartCity', '#AI', '#Sustainability'],
      category: 'Teknologi',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      impactScore: 8.5,
    ),
    InnovationVideo(
      id: 'v2',
      videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-little-girl-using-a-tablet-4545-large.mp4',
      thumbnailUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?q=80&w=800&auto=format&fit=crop',
      title: 'Platform EduConnect',
      description: 'Menghubungkan siswa di daerah terpencil dengan mentor dari universitas ternama. Pendidikan untuk semua.',
      creator: creators[1],
      likes: 3400,
      comments: 120,
      shares: 450,
      saves: 890,
      hashtags: ['#Education', '#Equality', '#Learning'],
      category: 'Pendidikan',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      impactScore: 9.2,
    ),
    InnovationVideo(
      id: 'v3',
      videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-wind-turbines-on-a-sunny-day-43285-large.mp4',
      thumbnailUrl: 'https://images.unsplash.com/photo-1466611653911-954ff2133ad2?q=80&w=800&auto=format&fit=crop',
      title: 'Ransel Panel Surya',
      description: 'Ransel dengan panel surya terintegrasi untuk mengisi daya perangkat sambil berjalan. Cocok untuk pelajar.',
      creator: creators[0],
      likes: 2100,
      comments: 67,
      shares: 120,
      saves: 340,
      hashtags: ['#GreenEnergy', '#Solar', '#Tech'],
      category: 'Lingkungan',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      impactScore: 7.8,
    ),
  ];

  static final List<InnovationBattle> battles = [
    InnovationBattle(
      id: 'b1',
      idea1: innovationVideos[0],
      idea2: innovationVideos[2],
      votes1: 450,
      votes2: 320,
      endTime: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  static final List<CollaborationProject> collaborationProjects = [
    CollaborationProject(
      id: 'p1',
      title: 'Pembersih Laut Global',
      description: 'Drone otonom untuk mendeteksi dan mengumpulkan limbah plastik di lautan.',
      members: [creators[0], creators[1], creators[2]],
      progress: 0.65,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      messages: [
        ProjectMessage(id: 'm1', senderId: '1', senderName: 'Khalif', message: 'Saya sudah menyelesaikan model deteksi AI.', time: DateTime.now().subtract(const Duration(hours: 5))),
        ProjectMessage(id: 'm2', senderId: '2', senderName: 'Salsa', message: 'Bagus! Saya akan memperbarui UI untuk dashboard.', time: DateTime.now().subtract(const Duration(hours: 2))),
      ],
    ),
  ];

  static final List<InnovationChallenge> challenges = [
    InnovationChallenge(
      id: 'c1',
      title: 'Kurangi Limbah Plastik',
      description: 'Buat inovasi yang membantu mengurangi konsumsi plastik di sekolah.',
      imageUrl: 'https://picsum.photos/800/400?random=10',
      participants: 120,
      reward: 'Rp 10.000.000 + Magang',
      deadline: DateTime.now().add(const Duration(days: 15)),
      categories: ['Lingkungan', 'Pendidikan'],
    ),
    InnovationChallenge(
      id: 'c2',
      title: 'Pendidikan Cerdas',
      description: 'Rancang alat atau platform untuk membuat pembelajaran online lebih interaktif.',
      imageUrl: 'https://picsum.photos/800/400?random=11',
      participants: 450,
      reward: 'Laptop Macbook Air + Beasiswa',
      deadline: DateTime.now().add(const Duration(days: 30)),
      categories: ['Pendidikan', 'Teknologi'],
    ),
  ];

  static final List<NotificationModel> notifications = [
    NotificationModel(
      id: 'n1',
      title: 'Suka Baru',
      message: 'Khalif menyukai proyek "Tempat Sampah Pintar AI" Anda.',
      type: 'like',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      fromUser: 'Khalif',
    ),
    NotificationModel(
      id: 'n2',
      title: 'Undangan Kolaborasi',
      message: 'Salsa mengundang Anda untuk bergabung dengan tim "EduConnect".',
      type: 'invite',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      fromUser: 'Salsa',
    ),
  ];

  static final List<Map<String, dynamic>> collaborationSkills = [
    {'name': 'Programmer', 'icon': Icons.code_rounded, 'color': Colors.blue},
    {'name': 'Desainer UI/UX', 'icon': Icons.brush_rounded, 'color': Colors.pink},
    {'name': 'Video Editor', 'icon': Icons.movie_rounded, 'color': Colors.orange},
    {'name': 'Public Speaker', 'icon': Icons.mic_rounded, 'color': Colors.purple},
    {'name': 'Content Creator', 'icon': Icons.camera_alt_rounded, 'color': Colors.cyan},
    {'name': 'Researcher', 'icon': Icons.search_rounded, 'color': Colors.green},
  ];
}
