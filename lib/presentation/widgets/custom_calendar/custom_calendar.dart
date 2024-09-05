import 'package:credit_card_transactions/data/models/month_data_model.dart';
import 'package:credit_card_transactions/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/widgets/default_box_builder.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/widgets/default_number_builder.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/widgets/dow_builder.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/widgets/no_data_tool_tip.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/widgets/selected_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    required this.year,
    required this.month,
    required this.monthData,
    required this.calendarBloc,
    super.key,
  });

  final int year;
  final int month;
  final MonthData monthData;
  final CalendarBloc calendarBloc;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late CalendarBloc _calendarBloc;

  @override
  initState() {
    _calendarBloc = widget.calendarBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      bloc: _calendarBloc,
      builder: (context, state) {
        if (state.calendarType == CalendarType.number) {
          return Container(
            width: 180,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white38),
            ),
            child: TableCalendar(
              firstDay: DateTime(widget.year, widget.month, 1),
              lastDay: DateTime(widget.year, widget.month,
                  getLastDayOfMonth(widget.year, widget.month).day),
              focusedDay: DateTime(widget.year, widget.month, 28),
              rowHeight: 26,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(day, state.selectedDate);
              },
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
                isTodayHighlighted: false,
              ),
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                leftChevronVisible: false,
                rightChevronVisible: false,
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return DefaultNumberBuilder(
                    day: day,
                    monthDays: widget.monthData.days,
                    calendarBloc: _calendarBloc,
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  if (state.selectedDate != null &&
                      isSameDay(day, state.selectedDate)) {
                    return SelectedBuilder(
                      day: day,
                      monthDays: widget.monthData.days,
                    );
                  } else {
                    return NoDataToolTip(day: '${day.day}');
                  }
                },
                dowBuilder: (context, day) {
                  final text = DateFormat.E().format(day);
                  return DowBuilder(text: text.substring(0, 1));
                },
              ),
            ),
          );
        }
        return Container(
          width: 180,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: TableCalendar(
            firstDay: DateTime(widget.year, widget.month, 1),
            lastDay: DateTime(
              widget.year,
              widget.month,
              getLastDayOfMonth(widget.year, widget.month).day,
            ),
            focusedDay: DateTime(widget.year, widget.month, 28),
            rowHeight: 24,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(day, state.selectedDate);
            },
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
              isTodayHighlighted: false,
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              leftChevronVisible: false,
              rightChevronVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return DefaultBoxBuilder(
                  day: day,
                  monthDays: widget.monthData.days,
                  calendarBloc: _calendarBloc,
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                if (state.selectedDate != null &&
                    isSameDay(day, state.selectedDate)) {
                  return SelectedBuilder(
                    day: day,
                    monthDays: widget.monthData.days,
                  );
                } else {
                  return NoDataToolTip(day: '${day.day}');
                }
              },
              dowBuilder: (context, day) {
                final text = DateFormat.E().format(day);
                return DowBuilder(text: text.substring(0, 1));
              },
              headerTitleBuilder: (context, day) {
                return Center(
                  child: Text(
                    DateFormat.MMM().format(day),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  DateTime getLastDayOfMonth(int year, int month) {
    DateTime firstDayOfNextMonth;
    if (month == 12) {
      firstDayOfNextMonth = DateTime(year + 1, 1, 1);
    } else {
      firstDayOfNextMonth = DateTime(year, month + 1, 1);
    }

    DateTime lastDayOfMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));

    return lastDayOfMonth;
  }
}
