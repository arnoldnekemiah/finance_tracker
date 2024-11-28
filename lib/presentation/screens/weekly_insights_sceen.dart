import 'package:flutter/material.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';

class WeeklyInsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Insights'),
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.richBlack,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWeeklyOverview(),
            _buildCategoryBreakdown(),
            _buildSavingGoals(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyOverview() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Add your weekly overview content here
            // For example: spending summary, income vs expenses, etc.
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category Breakdown',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Add your category breakdown content here
            // For example: pie chart or bar chart showing spending by category
          ],
        ),
      ),
    );
  }

  Widget _buildSavingGoals() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saving Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Add your saving goals content here
            // For example: progress bars for different saving goals
          ],
        ),
      ),
    );
  }
}
