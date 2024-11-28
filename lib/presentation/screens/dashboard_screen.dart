import 'package:finance_tracker/dummy/transactions.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final double currentBalance = 2150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Balance",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("\$${currentBalance.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 32, color: Colors.green)),
            SizedBox(height: 20),
            Text("Recent Transactions", style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return ListTile(
                    leading: Icon(
                      transaction["type"] == "Income"
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transaction["type"] == "Income"
                          ? Colors.green
                          : Colors.red,
                    ),
                    title: Text(transaction["category"]),
                    subtitle: Text(transaction["notes"] ?? ""),
                    trailing: Text(
                      "\$${transaction["amount"]}",
                      style: TextStyle(
                        color: transaction["type"] == "Income"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
