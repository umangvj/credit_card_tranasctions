import 'package:credit_card_transactions/data/datasource/transactions_service.dart';
import 'package:credit_card_transactions/data/repositories/transaction_repository_impl.dart';
import 'package:credit_card_transactions/domain/repositories/transaction_repository.dart';
import 'package:credit_card_transactions/domain/usecase/transaction_usecase.dart';
import 'package:credit_card_transactions/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:credit_card_transactions/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //Bloc
  getIt.registerFactory<TransactionBloc>(
    () => TransactionBloc(
      transactionUseCase: getIt(),
    ),
  );

  getIt.registerFactory<CalendarBloc>(
    () => CalendarBloc(),
  );

  // Use cases
  getIt.registerLazySingleton<TransactionUseCase>(
    () => TransactionUseCase(transactionRepository: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      transactionDataSource: getIt(),
    ),
  );

  // Data Sources
  getIt.registerLazySingleton<TransactionDataSource>(
    () => TransactionDataSource(),
  );

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
