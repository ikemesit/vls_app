class Donation {
  final String id;
  final double amount;
  final DateTime date;
  final String userId;
  final String? description;

  Donation({
    required this.id,
    required this.amount,
    required this.date,
    required this.userId,
    this.description,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      userId: json['userId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'date': date.toIso8601String(),
    'userId': userId,
    'description': description,
  };
}
