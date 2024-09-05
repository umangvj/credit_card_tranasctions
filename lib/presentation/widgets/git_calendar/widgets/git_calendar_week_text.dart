import 'package:flutter/material.dart';

import '../util/date_util.dart';

class GitCalendarWeekText extends StatelessWidget {
  const GitCalendarWeekText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (String label in DateUtil.weekLabel)
          Container(
            height: 20,
            margin: const EdgeInsets.all(2.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF4F4F4F),
              ),
            ),
          ),
      ],
    );
  }
}
