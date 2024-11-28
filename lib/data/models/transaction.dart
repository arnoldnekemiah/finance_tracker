enum TransactionType { income, expense }

class Transaction {
  final int id;
  final double amount;
  final String category;
  final TransactionType type;
  final DateTime date;
  final String? notes;

  const Transaction({
    required this.id,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    this.notes,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'].toDouble(),
      category: json['category'],
      type: json['type'] == 'Income'
          ? TransactionType.income
          : TransactionType.expense,
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'type': type == TransactionType.income ? 'Income' : 'Expense',
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}
