import 'package:credit_card_transactions/data/models/day_data_model.dart';
import 'package:credit_card_transactions/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:credit_card_transactions/presentation/widgets/git_calendar/util/date_util.dart';
import 'package:flutter/material.dart';

import 'git_calendar_container.dart';

class GitCalendarColumn extends StatelessWidget {
  final CalendarBloc calendarBloc;
  final DateTime startDate;
  final DateTime endDate;

  // The number of day blocks to draw. This should be seven for all but the current week.
  final int numDays;
  final Map<String, DayData> monthDays;

  /// The List widgets of [GitCalendarContainer].
  ///
  /// It includes every days of the week and
  /// if one week doesn't have 7 days, it will be filled with empty [Container].
  final List<Widget> dayContainers;

  /// The List widgets of empty [Container].
  /// It only processes when given week's length is not 7.
  final List<Widget> emptySpace;

  GitCalendarColumn({
    super.key,
    required this.calendarBloc,
    required this.startDate,
    required this.endDate,
    required this.numDays,
    required this.monthDays,
  })  : dayContainers = List.generate(
          numDays,
          (i) => GitCalendarContainer(
            calendarBloc: calendarBloc,
            day: DateUtil.changeDay(startDate, i),
            monthDays: monthDays,
          ),
        ),
        // Fill emptySpace list only if given wek doesn't have 7 days.
        emptySpace = (numDays != 7)
            ? List.generate(
                7 - numDays,
                (i) => Container(
                  margin: const EdgeInsets.all(2),
                  width: 42,
                  height: 42,
                ),
              )
            : [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[...dayContainers, ...emptySpace],
    );
  }
}
