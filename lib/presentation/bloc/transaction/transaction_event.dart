part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class GetTransactionData extends TransactionEvent {
  const GetTransactionData({required this.year});

  final String year;

  @override
  List<Object?> get props => [year];
}
