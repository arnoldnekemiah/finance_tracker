import 'package:flutter/material.dart';
import 'package:finance_tracker/data/models/saving_goal.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';

class SavingGoalsScreen extends StatelessWidget {
  final List<SavingGoal> goals = []; // Will be populated from your data source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving Goals'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddGoalDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          return _buildGoalCard(goal);
        },
      ),
    );
  }

  Widget _buildGoalCard(SavingGoal goal) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goal.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: goal.progressPercentage / 100,
              backgroundColor: AppColors.lightGold.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation(
                goal.isAchieved ? AppColors.success : AppColors.primaryGold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${goal.progressPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: goal.isAchieved
                        ? AppColors.success
                        : AppColors.primaryGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${goal.daysRemaining} days remaining',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddGoalDialog(BuildContext context) async {
    // Implementation for adding new saving goal
  }
}
