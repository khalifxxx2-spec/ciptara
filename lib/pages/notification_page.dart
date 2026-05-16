import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'Notifikasi'),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: AppDummyData.notifications.length,
        itemBuilder: (context, index) {
          final notif = AppDummyData.notifications[index];
          return _buildNotificationItem(notif);
        },
      ),
    );
  }

  Widget _buildNotificationItem(dynamic notif) {
    IconData icon;
    Color color;

    switch (notif.type) {
      case 'like':
        icon = Icons.favorite_rounded;
        color = Colors.redAccent;
        break;
      case 'comment':
        icon = Icons.comment_rounded;
        color = Colors.blueAccent;
        break;
      case 'invite':
        icon = Icons.group_add_rounded;
        color = AppColors.purple;
        break;
      default:
        icon = Icons.notifications_rounded;
        color = AppColors.cyan;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif.title,
                  style: AppTextStyles.heading(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  notif.message,
                  style: AppTextStyles.body(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  '2 jam yang lalu', // Static for dummy
                  style: AppTextStyles.caption(),
                ),
              ],
            ),
          ),
          if (notif.type == 'invite')
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cyan,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                minimumSize: const Size(60, 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
