// Model for a single transaction
class Transaction {
  String description;
  double amount;
  String type;
  String category;
  String time;
  int reference;

  Transaction({
    required this.description,
    required this.amount,
    required this.type,
    required this.category,
    required this.time,
    required this.reference,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      description: json['description'],
      amount: json['amount'],
      type: json['type'],
      category: json['category'],
      time: json['time'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'type': type,
      'category': category,
      'time': time,
      'reference': reference,
    };
  }
}
