import 'package:credit_card_transactions/data/models/api_error_model.dart';
import 'package:credit_card_transactions/data/models/credit_card_data_model.dart';
import 'package:credit_card_transactions/domain/repositories/transaction_repository.dart';
import 'package:dartz/dartz.dart';

class TransactionUseCase {
  TransactionUseCase({required this.transactionRepository});

  final TransactionRepository transactionRepository;

  Future<Either<ApiError, CreditCardData>> getTransactionData({
    required String year,
  }) async {
    return transactionRepository.getTransactionData(year: year);
  }
}
