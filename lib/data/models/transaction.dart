class Transaction {
  final String id;
  final double amount;
  final String category;
  final String type;
  final DateTime date;
  final String notes;
  final String? recurringId;

  const Transaction({
    required this.id,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    required this.notes,
    this.recurringId,
  });

  bool get isExpense => type == 'Expense';
  bool get isIncome => type == 'Income';
  bool get isRecurring => recurringId != null;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'].toString(),
      amount: json['amount'].toDouble(),
      category: json['category'],
      type: json['type'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
      recurringId: json['recurringId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'type': type,
      'date': date.toIso8601String(),
      'notes': notes,
      'recurringId': recurringId,
    };
  }
}
