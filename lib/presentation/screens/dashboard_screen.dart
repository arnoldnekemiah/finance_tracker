import 'package:finance_tracker/data/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';
import 'package:finance_tracker/presentation/widgets/budget_summary_card.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('My Wallet'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primaryGold, AppColors.darkBlue],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildBalanceCard(context),
                  const SizedBox(height: 20),
                  _buildBudgetOverview(),
                  const SizedBox(height: 20),
                  _buildWeeklySpendingChart(),
                  const SizedBox(height: 20),
                  _buildRecentTransactions(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add transaction
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total Balance',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '\$2,150.00',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.primaryGold,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklySpendingChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Spending',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 1000,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            return Text(
                              days[value.toInt() % 7],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    barGroups: [
                      _generateBarGroup(0, 500),
                      _generateBarGroup(1, 300),
                      _generateBarGroup(2, 750),
                      _generateBarGroup(3, 450),
                      _generateBarGroup(4, 600),
                      _generateBarGroup(5, 200),
                      _generateBarGroup(6, 900),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.primaryGold,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    // TODO: Replace with actual transaction data from state management
    final List<Map<String, dynamic>> transactions = [
      {
        'title': 'Grocery Shopping',
        'amount': -85.50,
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'category': 'Food'
      },
      {
        'title': 'Salary Deposit',
        'amount': 3000.00,
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'category': 'Income'
      },
      {
        'title': 'Netflix Subscription',
        'amount': -15.99,
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'category': 'Entertainment'
      },
    ];

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
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to transactions screen
                  },
                  child: Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final bool isExpense = transaction['amount'] < 0;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: isExpense
                        ? AppColors.error.withOpacity(0.1)
                        : AppColors.success.withOpacity(0.1),
                    child: Icon(
                      isExpense ? Icons.remove : Icons.add,
                      color: isExpense ? AppColors.error : AppColors.success,
                    ),
                  ),
                  title: Text(transaction['title']),
                  subtitle: Text(
                    transaction['category'],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isExpense ? '-' : '+'}\$${transaction['amount'].abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color:
                              isExpense ? AppColors.error : AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatDate(transaction['date']),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildBudgetOverview() {
    // Dummy data for now
    final List<Budget> budgets = [
      Budget(
        category: 'Food',
        limit: 500,
        spent: 350,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
      Budget(
        category: 'Transport',
        limit: 200,
        spent: 150,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
      Budget(
        category: 'Shopping',
        limit: 300,
        spent: 320,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Budget Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: budgets.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: BudgetSummaryCard(budget: budgets[index]),
            );
          },
        ),
      ],
    );
  }
}
