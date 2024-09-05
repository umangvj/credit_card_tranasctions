import 'package:credit_card_transactions/core/config/injection_container.dart';
import 'package:credit_card_transactions/core/constants/color_constants.dart';
import 'package:credit_card_transactions/data/models/month_data_model.dart';
import 'package:credit_card_transactions/data/models/transaction_model.dart';
import 'package:credit_card_transactions/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:credit_card_transactions/presentation/bloc/transaction/transaction_bloc.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/custom_calendar.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/util/data_formatter.dart';
import 'package:credit_card_transactions/presentation/widgets/git_calendar/git_calendar.dart';
import 'package:credit_card_transactions/presentation/widgets/git_calendar/util/date_util.dart';
import 'package:credit_card_transactions/presentation/widgets/gradient_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TransactionBloc _transactionBloc;
  late CalendarBloc _calendarBloc;

  @override
  void initState() {
    _transactionBloc = getIt<TransactionBloc>();
    _transactionBloc.add(const GetTransactionData(year: '2024'));
    _calendarBloc = getIt<CalendarBloc>();
    super.initState();
  }

  DateFormat format = DateFormat("d MMMM, yyyy");

  Color getTextColor(double amount) {
    return amount < 0
        ? Colors.red
        : amount > 0
            ? Colors.green
            : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<TransactionBloc, TransactionState>(
        bloc: _transactionBloc,
        listener: (context, state) {
          if (state.status == TransactionStatus.error &&
              state.apiError?.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.apiError?.message ?? 'An error occurred'),
              ),
            );
          } else if (state.resetCalendar) {
            _calendarBloc.add(
              const ResetSelectDate(),
            );
          }
        },
        builder: (context, state) {
          if (state.status == TransactionStatus.loaded) {
            return BlocBuilder<CalendarBloc, CalendarState>(
              bloc: _calendarBloc,
              builder: (context, calendarState) {
                return OrientationBuilder(builder: (context, orientation) {
                  return SingleChildScrollView(
                    child: orientation == Orientation.landscape
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: dateSelectionWidget(
                                  state: state,
                                  calendarState: calendarState,
                                  isLandScape: true,
                                ),
                              ),
                              Expanded(
                                child: transactionDisplayWidget(
                                  state: state,
                                  calendarState: calendarState,
                                  size: size,
                                  transactionHeight: size.height - 70,
                                  height: size.height,
                                  width: size.width,
                                  isLandScape: true,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dateSelectionWidget(
                                state: state,
                                calendarState: calendarState,
                                isLandScape: false,
                              ),
                              transactionDisplayWidget(
                                state: state,
                                calendarState: calendarState,
                                size: size,
                                transactionHeight: size.height > 900
                                    ? size.height * 0.6 - 55
                                    : size.height * 0.54 - 55,
                                height: size.height > 900
                                    ? size.height * 0.6
                                    : size.height * 0.54,
                                width: size.width,
                                isLandScape: false,
                              ),
                            ],
                          ),
                  );
                });
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget dateSelectionWidget({
    required TransactionState state,
    required CalendarState calendarState,
    required bool isLandScape,
  }) {
    return Column(
      children: [
        SizedBox(height: isLandScape ? 30 : 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Transactions History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: int.parse(state.year ?? '2024'),
                    padding: const EdgeInsets.only(left: 25),
                    isExpanded: true,
                    items: [2024, 2023].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _transactionBloc.add(
                        GetTransactionData(
                          year: value.toString(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 16),
        // SizedBox(
        //   height: 210,
        //   child: SingleChildScrollView(
        //     reverse: true,
        //     scrollDirection: Axis.horizontal,
        //     child: GitCalendar(
        //       startDate: DateUtil.oneYearBefore(DateTime.now()),
        //       endDate: DateTime.now(),
        //       calendarBloc: _calendarBloc,
        //       monthData: state.allMonthsData ?? MonthData(days: {}),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 16),
        SizedBox(
          height: 210,
          child: calendarState.calendarType == CalendarType.box ||
                  calendarState.calendarType == CalendarType.number
              ? ListView.builder(
                  itemCount: state.allMonthsData?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  itemBuilder: (context, index) {
                    return CustomCalendar(
                      year: format
                          .parse(
                            "1 ${state.allMonthsData?.keys.elementAt(index)}",
                          )
                          .year,
                      month: format
                          .parse(
                            "1 ${state.allMonthsData?.keys.elementAt(index)}",
                          )
                          .month,
                      monthData: state.allMonthsData?.values.elementAt(index) ??
                          MonthData(days: {}),
                      calendarBloc: _calendarBloc,
                    );
                  },
                )
              : SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: GitCalendar(
                    startDate: DateUtil.oneYearBefore(DateTime.now()),
                    endDate: DateTime.now(),
                    calendarBloc: _calendarBloc,
                    monthData: state.allDaysData ?? MonthData(days: {}),
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ToggleButtons(
                direction: Axis.horizontal,
                constraints: const BoxConstraints(
                  minHeight: 20,
                  minWidth: 30,
                ),
                onPressed: (int index) {
                  index == 0
                      ? _calendarBloc.add(
                          const CalendarTypeChanged(
                            calendarType: CalendarType.box,
                          ),
                        )
                      : index == 1
                          ? _calendarBloc.add(
                              const CalendarTypeChanged(
                                calendarType: CalendarType.number,
                              ),
                            )
                          : _calendarBloc.add(
                              const CalendarTypeChanged(
                                calendarType: CalendarType.git,
                              ),
                            );
                },
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                borderWidth: 1.5,
                selectedBorderColor: ColorConstants.primaryShade4,
                borderColor: Colors.grey.shade800,
                selectedColor: Colors.transparent,
                fillColor: Colors.transparent,
                isSelected: [
                  calendarState.calendarType == CalendarType.box,
                  calendarState.calendarType == CalendarType.number,
                  calendarState.calendarType == CalendarType.git,
                ],
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    height: 14,
                    width: 14,
                    margin: const EdgeInsets.only(left: 2),
                    child: Center(
                      child: Text(
                        DateTime.now().day.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 14,
                    width: 14,
                    margin: const EdgeInsets.only(left: 2),
                    child: Center(
                      child: Text(
                        'Git',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const GradientViewer(),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget transactionDisplayWidget({
    required TransactionState state,
    required CalendarState calendarState,
    required Size size,
    required double transactionHeight,
    double? height,
    double? width,
    required bool isLandScape,
  }) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            ColorConstants.primaryShade9,
            ColorConstants.primaryShade10,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: calendarState.selectedDate != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLandScape) const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Transactions on ${DataFormatter.fullDateFormat.format(calendarState.selectedDate!)}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (calendarState.selectedDateData != null)
                      Text(
                        '₹${calendarState.selectedDateData?.total.toStringAsFixed(2) ?? '0.00'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: getTextColor(
                              calendarState.selectedDateData?.total ?? 0),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                calendarState.selectedDateData != null &&
                        calendarState
                                .selectedDateData?.transactions.isNotEmpty ==
                            true
                    ? SizedBox(
                        height: transactionHeight,
                        width: width,
                        child: ListView.builder(
                            itemCount: calendarState
                                    .selectedDateData?.transactions.length ??
                                0,
                            padding: const EdgeInsets.only(bottom: 20),
                            itemBuilder: (context, index) {
                              List<Transaction> transactions = calendarState
                                      .selectedDateData?.transactions ??
                                  [];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          transactions[index].description,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Ref# ${transactions[index].reference}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '₹${transactions[index].amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: getTextColor(
                                            transactions[index].amount),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text(
                            'No transactions found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
              ],
            )
          : Padding(
              padding: isLandScape
                  ? EdgeInsets.zero
                  : EdgeInsets.only(bottom: transactionHeight / 2),
              child: const Center(
                child: Text(
                  'Select a date to view transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
    );
  }
}
