class SavingGoal {
  final String id;
  final String title;
  final double targetAmount;
  final double currentAmount;
  final DateTime targetDate;
  final String? notes;

  const SavingGoal({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.targetDate,
    this.notes,
  });

  double get progressPercentage => (currentAmount / targetAmount) * 100;
  bool get isAchieved => currentAmount >= targetAmount;
  int get daysRemaining => targetDate.difference(DateTime.now()).inDays;

  factory SavingGoal.fromJson(Map<String, dynamic> json) {
    return SavingGoal(
      id: json['id'],
      title: json['title'],
      targetAmount: json['targetAmount'].toDouble(),
      currentAmount: json['currentAmount'].toDouble(),
      targetDate: DateTime.parse(json['targetDate']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'targetDate': targetDate.toIso8601String(),
      'notes': notes,
    };
  }
}
