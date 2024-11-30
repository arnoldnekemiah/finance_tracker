enum RecurringPeriod { daily, weekly, monthly, yearly }

class RecurringTransaction {
  final String id;
  final double amount;
  final String category;
  final String description;
  final RecurringPeriod period;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;

  const RecurringTransaction({
    required this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.period,
    required this.startDate,
    this.endDate,
    this.isActive = true,
  });

  factory RecurringTransaction.fromJson(Map<String, dynamic> json) {
    return RecurringTransaction(
      id: json['id'],
      amount: json['amount'].toDouble(),
      category: json['category'],
      description: json['description'],
      period: RecurringPeriod.values.firstWhere(
        (e) => e.toString() == json['period'],
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isActive: json['isActive'] ?? true,
    );
  }
}
