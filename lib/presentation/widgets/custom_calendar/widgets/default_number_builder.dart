import 'package:credit_card_transactions/core/constants/color_constants.dart';
import 'package:credit_card_transactions/data/models/day_data_model.dart';
import 'package:credit_card_transactions/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/util/data_formatter.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/widgets/no_data_tool_tip.dart';
import 'package:flutter/material.dart';

class DefaultNumberBuilder extends StatefulWidget {
  const DefaultNumberBuilder({
    required this.day,
    required this.monthDays,
    required this.calendarBloc,
    super.key,
  });

  final DateTime day;
  final Map<String, DayData> monthDays;
  final CalendarBloc calendarBloc;

  @override
  State<DefaultNumberBuilder> createState() => _DefaultNumberBuilderState();
}

class _DefaultNumberBuilderState extends State<DefaultNumberBuilder> {
  late CalendarBloc _calendarBloc;

  @override
  void initState() {
    _calendarBloc = widget.calendarBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.monthDays
        .containsKey(DataFormatter.dayMonthFormat.format(widget.day))) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _calendarBloc.add(
                CalendarDateSelected(
                  date: widget.day,
                  selectedDateData: widget.monthDays[
                      DataFormatter.dayMonthFormat.format(widget.day)]!,
                ),
              );
            },
            child: Tooltip(
              message:
                  'Total amount spent on ${DataFormatter.fullDateFormat.format(widget.day)}: ₹${widget.monthDays[DataFormatter.dayMonthFormat.format(widget.day)]!.total.abs()}',
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 10,
                  minHeight: 10,
                ),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: getGradient(
                    total: widget
                        .monthDays[
                            DataFormatter.dayMonthFormat.format(widget.day)]!
                        .total,
                    monthTotal: widget.monthDays.values
                        .map((e) => e.total)
                        .reduce((value, element) => value + element),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${widget.day.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: GestureDetector(
          onTap: () {
            _calendarBloc.add(
              CalendarDateSelected(
                date: widget.day,
                selectedDateData: DayData(
                  total: 0,
                  transactions: [],
                ),
              ),
            );
          },
          child: NoDataToolTip(day: '${widget.day.day}'),
        ),
      );
    }
  }
}

Gradient getGradient({required double total, required double monthTotal}) {
  total = total.abs();
  monthTotal = monthTotal.abs();
  if (total < monthTotal * 0.05) {
    return ColorConstants.gradient1;
  } else if (total < monthTotal * 0.2) {
    return ColorConstants.gradient2;
  } else if (total < monthTotal * 0.5) {
    return ColorConstants.gradient3;
  } else {
    return ColorConstants.gradient4;
  }
}
