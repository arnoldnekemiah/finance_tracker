import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finance_tracker/core/theme/app_theme.dart';

class InsightsScreen extends StatelessWidget {
  final Map<String, double> spendingSummary = {
    "Food": 150.0,
    "Transport": 200.0,
    "Shopping": 500.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insights")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Spending by Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: spendingSummary.entries.map((entry) {
                    final category = entry.key;
                    final amount = entry.value;
                    final color = _getColorForCategory(category);
                    return PieChartSectionData(
                      color: color,
                      value: amount,
                      title: "${amount.toStringAsFixed(0)}",
                      titleStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case "Food":
        return AppColors.primaryGold;
      case "Transport":
        return AppColors.midnightBlue;
      case "Shopping":
        return AppColors.darkGold;
      default:
        return AppColors.lightBlue;
    }
  }
}
