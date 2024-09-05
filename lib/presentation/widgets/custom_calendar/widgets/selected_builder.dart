import 'package:credit_card_transactions/data/models/day_data_model.dart';
import 'package:credit_card_transactions/presentation/widgets/custom_calendar/util/data_formatter.dart';
import 'package:flutter/material.dart';

class SelectedBuilder extends StatelessWidget {
  const SelectedBuilder({
    required this.day,
    required this.monthDays,
    super.key,
  });

  final DateTime day;
  final Map<String, DayData> monthDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: monthDays
                  .containsKey(DataFormatter.dayMonthFormat.format(day))
              ? 'Total amount spent on ${DataFormatter.fullDateFormat.format(day)}: ₹${monthDays[DataFormatter.dayMonthFormat.format(day)]!.total.abs()}'
              : 'No Data',
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
              border: Border.all(
                color: const Color(0xffff8a16),
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
