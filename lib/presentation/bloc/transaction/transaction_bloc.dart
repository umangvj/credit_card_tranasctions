import 'package:credit_card_transactions/data/models/api_error_model.dart';
import 'package:credit_card_transactions/data/models/credit_card_data_model.dart';
import 'package:credit_card_transactions/data/models/day_data_model.dart';
import 'package:credit_card_transactions/data/models/month_data_model.dart';
import 'package:credit_card_transactions/domain/usecase/transaction_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required TransactionUseCase transactionUseCase})
      : _transactionUseCase = transactionUseCase,
        super(const TransactionState()) {
    on<GetTransactionData>(_mapGetTransactionDataToState);
  }

  Future<void> _mapGetTransactionDataToState(
    GetTransactionData event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
        state.copyWith(status: TransactionStatus.loading, resetCalendar: true));
    final response =
        await _transactionUseCase.getTransactionData(year: event.year);
    await Future.delayed(const Duration(seconds: 2));
    response.fold(
        (error) => emit(
              state.copyWith(
                status: TransactionStatus.error,
                apiError: error,
                resetCalendar: false,
              ),
            ), (data) {
      Map<String, MonthData> allMonths = {};
      Map<String, DayData> allDays = {};
      for (var year in data.years.entries) {
        allMonths.addAll(year.value.months
            .map((key, value) => MapEntry('$key, ${year.key}', value)));
      }
      for (var month in allMonths.values) {
        allDays.addAll(month.days);
      }
      MonthData allDaysData = MonthData(days: allDays);
      emit(state.copyWith(
        year: event.year,
        status: TransactionStatus.loaded,
        allMonthsData: allMonths,
        allDaysData: allDaysData,
        creditCardData: data,
        resetCalendar: false,
      ));
    });
  }

  final TransactionUseCase _transactionUseCase;
}
