import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GitCalendarMonthText extends StatelessWidget {
  const GitCalendarMonthText({
    required this.firstDayInfo,
    super.key,
  });

  final List<int>? firstDayInfo;

  List<Widget> _labels() {
    List<Widget> items = [];

    // Set true if previous week was the first day of the month.
    bool write = false;

    // Loop until check every given weeks.
    for (int label = 0; label < (firstDayInfo?.length ?? 0); label++) {
      // If given week is first week of given dateset or
      // first week of month, create labels
      if (label == 0 ||
          (label > 0 && firstDayInfo![label] != firstDayInfo![label - 1])) {
        write = true;

        // Add SizedBox if first week is end of the month.
        // Otherwise, add Text with width margin.
        items.add(
          firstDayInfo!.length == 1 ||
                  (label == 0 &&
                      firstDayInfo![label] != firstDayInfo![label + 1])
              ? const SizedBox()
              : Container(
                  width: 44,
                  margin: const EdgeInsets.only(left: 2, right: 2),
                  child: _renderText(
                    DateFormat.MMM()
                        .format(DateTime(2024, firstDayInfo![label])),
                  ),
                ),
        );
      } else if (write) {
        // If given week is the next week of labeled week do nothing.
        write = false;
      } else {
        // Else create empty box.
        items.add(
          Container(
            margin: const EdgeInsets.only(left: 2, right: 2),
            width: 20,
          ),
        );
      }
    }

    return items;
  }

  Widget _renderText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _labels(),
    );
  }
}
