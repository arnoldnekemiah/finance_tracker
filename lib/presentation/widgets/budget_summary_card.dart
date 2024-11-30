import 'package:flutter/material.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';
import 'package:finance_tracker/data/models/budget.dart';

class BudgetSummaryCard extends StatelessWidget {
  final Budget budget;

  const BudgetSummaryCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  budget.category,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${budget.percentageUsed.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: budget.isOverBudget
                        ? AppColors.error
                        : AppColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: budget.spent / budget.limit,
              backgroundColor: AppColors.lightGold.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation(
                budget.isOverBudget ? AppColors.error : AppColors.success,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spent: \$${budget.spent.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Limit: \$${budget.limit.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
