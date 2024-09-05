import 'package:flutter/material.dart';

class NoDataToolTip extends StatelessWidget {
  const NoDataToolTip({
    required this.day,
    super.key,
  });

  final String day;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'No Data',
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      child: Center(
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
