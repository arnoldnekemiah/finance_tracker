class Budget {
  final String category;
  final double limit;
  final double spent;
  final DateTime startDate;
  final DateTime endDate;

  const Budget({
    required this.category,
    required this.limit,
    required this.spent,
    required this.startDate,
    required this.endDate,
  });

  double get remainingAmount => limit - spent;
  double get percentageUsed => (spent / limit) * 100;
  bool get isOverBudget => spent > limit;

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      category: json['category'],
      limit: json['limit'].toDouble(),
      spent: json['spent'].toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'limit': limit,
      'spent': spent,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
