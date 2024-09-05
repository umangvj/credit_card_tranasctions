import 'package:credit_card_transactions/core/utils/json_reader.dart';
import 'package:credit_card_transactions/data/models/credit_card_data_model.dart';

class TransactionDataSource {
  Future<CreditCardData> getTransactionData({required String year}) async {
    try {
      final jsonMap = await JsonReader().readJson('transactions_$year');
      final response = CreditCardData.fromJson(jsonMap);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
