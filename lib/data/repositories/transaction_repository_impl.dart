import 'package:credit_card_transactions/data/datasource/transactions_service.dart';
import 'package:credit_card_transactions/data/models/api_error_model.dart';
import 'package:credit_card_transactions/data/models/credit_card_data_model.dart';
import 'package:credit_card_transactions/domain/repositories/transaction_repository.dart';
import 'package:dartz/dartz.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  TransactionRepositoryImpl(
      {required TransactionDataSource transactionDataSource})
      : _transactionDataSource = transactionDataSource;

  final TransactionDataSource _transactionDataSource;

  @override
  Future<Either<ApiError, CreditCardData>> getTransactionData(
      {required String year}) async {
    try {
      final response =
          await _transactionDataSource.getTransactionData(year: year);
      return Right(response);
    } on Exception catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
