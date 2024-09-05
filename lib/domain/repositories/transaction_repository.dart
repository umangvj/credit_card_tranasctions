import 'package:credit_card_transactions/data/models/api_error_model.dart';
import 'package:credit_card_transactions/data/models/credit_card_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class TransactionRepository {
  Future<Either<ApiError, CreditCardData>> getTransactionData(
      {required String year});
}
