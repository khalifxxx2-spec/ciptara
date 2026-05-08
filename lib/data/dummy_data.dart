import '../models/idea_model.dart';

class DummyData {
  static const List<IdeaModel> allIdeas = [
    IdeaModel(
      id: '1',
      title: 'Smart Campus Navigator',
      description:
          'Aplikasi AR untuk navigasi kampus berbasis augmented reality yang memudahkan mahasiswa baru menemukan ruang kelas, laboratorium, dan fasilitas kampus.',
      creatorName: 'Khalif Rahmad',
      creatorInitials: 'KR',
      likes: 142,
      category: 'Teknologi',
      timeAgo: '2 jam lalu',
    ),
    IdeaModel(
      id: '2',
      title: 'Platform Barter Ilmu',
      description:
          'Marketplace digital untuk pertukaran keahlian antar mahasiswa. Bisa coding? Tukar dengan desain grafis atau keterampilan lainnya!',
      creatorName: 'Dita Ayu',
      creatorInitials: 'DA',
      likes: 98,
      category: 'Sosial',
      timeAgo: '5 jam lalu',
    ),
    IdeaModel(
      id: '3',
      title: 'EcoTrack Kampus',
      description:
          'Sistem monitoring konsumsi energi dan sampah di kampus secara real-time untuk mendorong gaya hidup berkelanjutan di lingkungan akademik.',
      creatorName: 'Reza Firmansyah',
      creatorInitials: 'RF',
      likes: 76,
      category: 'Lingkungan',
      timeAgo: '1 hari lalu',
    ),
    IdeaModel(
      id: '4',
      title: 'AI Study Buddy',
      description:
          'Asisten belajar berbasis AI yang mempersonalisasi metode belajar berdasarkan gaya belajar dan kemajuan tiap pelajar secara adaptif.',
      creatorName: 'Sinta Dewi',
      creatorInitials: 'SD',
      likes: 215,
      category: 'Pendidikan',
      timeAgo: '2 hari lalu',
    ),
    IdeaModel(
      id: '5',
      title: 'Beasiswa Finder',
      description:
          'Aggregator beasiswa nasional dan internasional dengan fitur pencocokan otomatis berdasarkan profil akademik dan kebutuhan mahasiswa.',
      creatorName: 'Ahmad Fauzi',
      creatorInitials: 'AF',
      likes: 189,
      category: 'Pendidikan',
      timeAgo: '3 hari lalu',
    ),
  ];

  static const List<IdeaModel> myIdeas = [
    IdeaModel(
      id: '1',
      title: 'Smart Campus Navigator',
      description:
          'Aplikasi AR untuk navigasi kampus berbasis augmented reality yang memudahkan mahasiswa baru.',
      creatorName: 'Khalif Rahmad',
      creatorInitials: 'KR',
      likes: 142,
      category: 'Teknologi',
      timeAgo: '2 jam lalu',
    ),
    IdeaModel(
      id: '6',
      title: 'Warung Digital UMKM',
      description:
          'Platform e-commerce khusus UMKM lokal dengan fitur manajemen stok sederhana dan laporan keuangan otomatis.',
      creatorName: 'Khalif Rahmad',
      creatorInitials: 'KR',
      likes: 67,
      category: 'Bisnis',
      timeAgo: '1 minggu lalu',
    ),
    IdeaModel(
      id: '7',
      title: 'Jurnal Belajarku',
      description:
          'Aplikasi jurnal digital untuk mencatat progress belajar harian dengan gamifikasi dan reminder cerdas.',
      creatorName: 'Khalif Rahmad',
      creatorInitials: 'KR',
      likes: 53,
      category: 'Pendidikan',
      timeAgo: '2 minggu lalu',
    ),
  ];
}
