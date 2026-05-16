import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class AnalyticsDashboardPage extends StatelessWidget {
  const AnalyticsDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: const GradientAppBar(title: 'Analytics Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatGrid(),
            const SizedBox(height: 30),
            Text('Engagement Growth', style: AppTextStyles.heading(fontSize: 18)),
            const SizedBox(height: 20),
            _buildLineChart(),
            const SizedBox(height: 30),
            Text('Impact Distribution', style: AppTextStyles.heading(fontSize: 18)),
            const SizedBox(height: 20),
            _buildBarChart(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Total Impact', '9.4', Icons.auto_awesome, AppColors.cyan),
        _buildStatCard('Engagement', '+24%', Icons.trending_up_rounded, Colors.greenAccent),
        _buildStatCard('Collaboration', '12', Icons.people_rounded, AppColors.purple),
        _buildStatCard('Rank', '#3', Icons.emoji_events_rounded, Colors.amber),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.caption(fontSize: 12)),
              Icon(icon, color: color, size: 18),
            ],
          ),
          Text(value, style: AppTextStyles.display(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 1),
                FlSpot(2, 4),
                FlSpot(3, 2),
                FlSpot(4, 5),
                FlSpot(5, 3),
                FlSpot(6, 4),
              ],
              isCurved: true,
              color: AppColors.cyan,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.cyan.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceLight, width: 1),
      ),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: AppColors.purple, width: 12)]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: AppColors.cyan, width: 12)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: AppColors.purple, width: 12)]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: AppColors.cyan, width: 12)]),
            BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 13, color: AppColors.purple, width: 12)]),
          ],
        ),
      ),
    );
  }
}
