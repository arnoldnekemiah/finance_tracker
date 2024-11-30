import 'package:flutter/material.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';
import 'package:finance_tracker/data/models/budget.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetManagementScreen extends StatefulWidget {
  @override
  _BudgetManagementScreenState createState() => _BudgetManagementScreenState();
}

class _BudgetManagementScreenState extends State<BudgetManagementScreen> {
  final List<Budget> budgets = []; // Will be populated from your data source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddBudgetDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBudgetVsActualChart(),
            _buildCategoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetVsActualChart() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          groupsSpace: 12,
          barGroups: _generateBarGroups(),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    budgets[value.toInt()].category,
                    style: TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return budgets.asMap().entries.map((entry) {
      final index = entry.key;
      final budget = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: budget.limit,
            color: AppColors.primaryGold,
            width: 12,
          ),
          BarChartRodData(
            toY: budget.spent,
            color: AppColors.darkBlue,
            width: 12,
          ),
        ],
      );
    }).toList();
  }

  Future<void> _showAddBudgetDialog(BuildContext context) async {
    // Implementation for adding new budget
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: budgets.length,
      itemBuilder: (context, index) {
        final budget = budgets[index];
        final percentSpent = budget.spent / budget.limit * 100;

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(budget.category),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: budget.spent / budget.limit,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(
                    percentSpent >= 100 ? Colors.red : AppColors.primaryGold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Spent: \$${budget.spent.toStringAsFixed(2)} / \$${budget.limit.toStringAsFixed(2)} (${percentSpent.toStringAsFixed(1)}%)',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // TODO: Implement edit budget functionality
              },
            ),
          ),
        );
      },
    );
  }
}
