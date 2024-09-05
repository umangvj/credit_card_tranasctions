part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, loaded, error }

class TransactionState extends Equatable {
  const TransactionState({
    this.year,
    this.creditCardData,
    this.resetCalendar = false,
    this.allDaysData,
    this.allMonthsData,
    this.apiError,
    this.status = TransactionStatus.initial,
  });

  final String? year;
  final bool resetCalendar;
  final CreditCardData? creditCardData;
  final MonthData? allDaysData;
  final Map<String, MonthData>? allMonthsData;
  final ApiError? apiError;
  final TransactionStatus status;

  @override
  List<Object?> get props => [
        year,
        creditCardData,
        allDaysData,
        allMonthsData,
        resetCalendar,
        apiError,
        status,
      ];

  TransactionState copyWith({
    String? year,
    CreditCardData? creditCardData,
    MonthData? allDaysData,
    Map<String, MonthData>? allMonthsData,
    bool? resetCalendar,
    ApiError? apiError,
    TransactionStatus? status,
  }) {
    return TransactionState(
      year: year ?? this.year,
      creditCardData: creditCardData ?? this.creditCardData,
      allDaysData: allDaysData ?? this.allDaysData,
      allMonthsData: allMonthsData ?? this.allMonthsData,
      resetCalendar: resetCalendar ?? this.resetCalendar,
      apiError: apiError ?? this.apiError,
      status: status ?? this.status,
    );
  }
}
