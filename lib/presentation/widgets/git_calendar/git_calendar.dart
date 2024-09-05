import 'dart:math';

import 'package:credit_card_transactions/data/models/month_data_model.dart';
import 'package:credit_card_transactions/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:credit_card_transactions/presentation/widgets/git_calendar/util/date_util.dart';
import 'package:credit_card_transactions/presentation/widgets/git_calendar/widgets/git_calendar_column.dart';
import 'package:credit_card_transactions/presentation/widgets/git_calendar/widgets/git_calendar_month_text.dart';
import 'package:credit_card_transactions/presentation/widgets/git_calendar/widgets/git_calendar_week_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GitCalendar extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final CalendarBloc calendarBloc;
  final MonthData monthData;

  // The number of days between startDate and endDate.
  final int _dateDifferent;

  GitCalendar({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.calendarBloc,
    required this.monthData,
  }) : _dateDifferent = endDate.difference(startDate).inDays;

  @override
  State<GitCalendar> createState() => _GitCalendarState();
}

class _GitCalendarState extends State<GitCalendar> {
  late CalendarBloc _calendarBloc;

  @override
  void initState() {
    _calendarBloc = widget.calendarBloc;
    super.initState();
  }

  // List value of every sunday's month.
  final List<int> _firstDayInfo = [];

  // Get GitCalendar from startDate to endDate.
  List<Widget> _gitCalendarColumnList({required CalendarBloc calendarBloc}) {
    // Create empty list.
    List<Widget> columns = [];
    if (_firstDayInfo.isNotEmpty) {
      _firstDayInfo.clear();
    }
    // Set position to first day of weeks
    // until position reaches the final week.
    for (int datePos = 0 - (widget.startDate.weekday % 7);
        datePos <= widget._dateDifferent;
        datePos += 7) {
      // Get first day of week by adding position's value to startDate.
      DateTime firstDay = DateUtil.changeDay(widget.startDate, datePos);

      columns.add(GitCalendarColumn(
        calendarBloc: calendarBloc,
        monthDays: widget.monthData.days,
        startDate: firstDay,
        endDate: datePos <= widget._dateDifferent - 7
            ? DateUtil.changeDay(widget.startDate, datePos + 6)
            : widget.endDate,
        numDays: min(widget.endDate.difference(firstDay).inDays + 1, 7),
      ));

      // also add first day's month information to _firstDayInfo list.
      _firstDayInfo.add(firstDay.month);
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      bloc: _calendarBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const GitCalendarWeekText(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GitCalendarMonthText(
                        firstDayInfo: _firstDayInfo,
                      ),
                      Row(
                        children: _gitCalendarColumnList(
                          calendarBloc: _calendarBloc,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
