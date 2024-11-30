import 'package:finance_tracker/dummy/spending_summary.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';
import 'package:finance_tracker/data/models/transaction.dart';

class InsightsScreen extends StatefulWidget {
  @override
  _InsightsScreenState createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Insights'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Overview'),
            Tab(text: 'Categories'),
            Tab(text: 'Trends'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildCategoriesTab(),
          _buildTrendsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMonthlyOverview(),
          SizedBox(height: 20),
          _buildIncomeVsExpenses(),
          SizedBox(height: 20),
          _buildTopCategories(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: PieChart(
            PieChartData(
              sections: _generatePieChartSections(),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: _buildCategoryList(),
        ),
      ],
    );
  }

  Widget _buildTrendsTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSpendingTrendChart(),
          SizedBox(height: 10),
          _buildTrendAnalysis(),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections() {
    // Implementation using your spending summary data
    return spendingSummary.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: '${entry.key}\n${entry.value.toStringAsFixed(0)}',
        color: _getCategoryColor(entry.key),
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color _getCategoryColor(String category) {
    // Implement your category color logic here
    final colors = {
      'Food': Colors.orange,
      'Transport': Colors.blue,
      'Shopping': Colors.purple,
      'Entertainment': Colors.green,
      'Bills': Colors.red,
    };
    return colors[category] ?? Colors.grey;
  }

  Widget _buildMonthlyOverview() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOverviewItem(
                    'Income', 5000.0, Icons.arrow_upward, AppColors.success),
                _buildOverviewItem(
                    'Expenses', 3200.0, Icons.arrow_downward, AppColors.error),
                _buildOverviewItem(
                    'Savings', 1800.0, Icons.savings, AppColors.primaryGold),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(
      String title, double amount, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        SizedBox(height: 8),
        Text(title),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeVsExpenses() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income vs Expenses',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 6000,
                  barGroups: [
                    _makeGroupData(0, 5000, AppColors.success),
                    _makeGroupData(1, 3200, AppColors.error),
                  ],
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('Income');
                            case 1:
                              return Text('Expenses');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 25,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildTopCategories() {
    final Map<String, double> spendingSummary = {
      "Food": 150.0,
      "Transport": 200.0,
      "Shopping": 500.0,
      "Entertainment": 300.0,
      "Bills": 800.0,
    };

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Spending Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            ...spendingSummary.entries
                .map((e) => _buildCategoryProgressBar(e.key, e.value))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryProgressBar(String category, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category),
              Text('\$${amount.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: amount / 1000, // Using 1000 as max value for demonstration
            backgroundColor: AppColors.lightGold.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(_getCategoryColor(category)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: spendingSummary.length,
      itemBuilder: (context, index) {
        final entry = spendingSummary.entries.elementAt(index);
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getCategoryColor(entry.key),
              child: Icon(Icons.category, color: Colors.white),
            ),
            title: Text(entry.key),
            trailing: Text(
              '\$${entry.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getCategoryColor(entry.key),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpendingTrendChart() {
    return Container(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Jan');
                    case 2:
                      return Text('Mar');
                    case 4:
                      return Text('May');
                    case 6:
                      return Text('Jul');
                    default:
                      return Text('');
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3000),
                FlSpot(1, 2500),
                FlSpot(2, 3200),
                FlSpot(3, 2800),
                FlSpot(4, 3800),
                FlSpot(5, 3100),
                FlSpot(6, 3400),
              ],
              isCurved: true,
              color: AppColors.primaryGold,
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primaryGold.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Analysis',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // SizedBox(height: 10),
            _buildTrendItem(
              icon: Icons.arrow_upward,
              title: 'Highest Spending',
              value: 'Food - \$800',
              color: AppColors.error,
            ),
            // SizedBox(height: 10),
            _buildTrendItem(
              icon: Icons.arrow_downward,
              title: 'Lowest Spending',
              value: 'Entertainment - \$200',
              color: AppColors.success,
            ),
            SizedBox(height: 12),
            _buildTrendItem(
              icon: Icons.trending_up,
              title: 'Monthly Trend',
              value: '+12% vs Last Month',
              color: AppColors.primaryGold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey)),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
