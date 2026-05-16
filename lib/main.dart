import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home_page.dart';
import 'pages/explore_page.dart';
import 'pages/upload_page.dart';
import 'pages/collaboration_page.dart';
import 'pages/profile_page.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.darkBlue,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const CiptaraApp());
}

class CiptaraApp extends StatelessWidget {
  const CiptaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ciptara.id',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    UploadPage(),
    CollaborationPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // For profile tabs
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: _currentIndex == 0 ? Colors.black : AppColors.darkBlue,
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_rounded, Icons.home_outlined, 'Beranda'),
            _buildNavItem(1, Icons.explore_rounded, Icons.explore_outlined, 'Explore'),
            _buildUploadBtn(),
            _buildNavItem(3, Icons.people_rounded, Icons.people_outline_rounded, 'Match'),
            _buildNavItem(4, Icons.person_rounded, Icons.person_outlined, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final bool isSelected = _currentIndex == index;
    final color = _currentIndex == 0 ? Colors.white : AppColors.textPrimary;
    
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : inactiveIcon,
            color: isSelected ? AppColors.cyan : color.withValues(alpha: 0.6),
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.cyan : color.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBtn() {
    return GestureDetector(
      onTap: () => _onTabTapped(2),
      child: Container(
        width: 45,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [Colors.cyan, Colors.purple],
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
