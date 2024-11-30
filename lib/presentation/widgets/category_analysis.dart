import 'package:finance_tracker/core/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/data/models/transaction.dart';

class CategoryAnalysis extends StatelessWidget {
  final String category;
  final List<Transaction> transactions;
  final double budgetLimit;

  const CategoryAnalysis({
    required this.category,
    required this.transactions,
    required this.budgetLimit,
  });

  @override
  Widget build(BuildContext context) {
    final categoryTransactions = transactions
        .where((t) => t.category == category && t.isExpense)
        .toList();
    final totalSpent = categoryTransactions.fold<double>(
        0, (sum, transaction) => sum + transaction.amount);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            _buildSpendingTrend(categoryTransactions),
            SizedBox(height: 16),
            _buildTransactionList(categoryTransactions),
            SizedBox(height: 16),
            _buildStatistics(totalSpent, categoryTransactions.length),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingTrend(List<Transaction> transactions) {
    final List<FlSpot> spots = [];
    if (transactions.isNotEmpty) {
      // Group transactions by date and calculate daily totals
      final Map<DateTime, double> dailyTotals = {};
      for (var transaction in transactions) {
        final date = DateTime(
          transaction.date.year,
          transaction.date.month,
          transaction.date.day,
        );
        dailyTotals[date] = (dailyTotals[date] ?? 0) + transaction.amount;
      }

      // Convert to spots for the line chart
      var sortedDates = dailyTotals.keys.toList()..sort();
      for (var i = 0; i < sortedDates.length; i++) {
        spots.add(FlSpot(i.toDouble(), dailyTotals[sortedDates[i]]!));
      }
    }

    return Container(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primaryGold,
              barWidth: 3,
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(double totalSpent, int transactionCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Spent: \$${totalSpent.toStringAsFixed(2)}'),
        Text('Number of Transactions: $transactionCount'),
        Text(
            'Average Transaction: \$${(totalSpent / transactionCount).toStringAsFixed(2)}'),
        Text(
            'Budget Utilization: ${((totalSpent / budgetLimit) * 100).toStringAsFixed(1)}%'),
      ],
    );
  }

  Widget _buildTransactionList(List<Transaction> transactions) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text(transaction.notes),
          subtitle: Text(_formatDate(transaction.date)),
          trailing: Text(
            '\$${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
