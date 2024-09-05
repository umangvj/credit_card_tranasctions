// Model for the transactions of a single day
import 'package:credit_card_transactions/data/models/transaction_model.dart';

class DayData {
  List<Transaction> transactions;
  double total;

  DayData({
    required this.transactions,
    required this.total,
  });

  factory DayData.fromJson(Map<String, dynamic> json) {
    var transactionsList = json['transactions'] as List;
    List<Transaction> transactions =
        transactionsList.map((t) => Transaction.fromJson(t)).toList();

    return DayData(
      transactions: transactions,
      total: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions.map((t) => t.toJson()).toList(),
      'total': total,
    };
  }
}
