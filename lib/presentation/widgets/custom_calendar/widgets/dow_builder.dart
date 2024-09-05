import 'package:flutter/material.dart';

class DowBuilder extends StatelessWidget {
  const DowBuilder({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text.substring(0, 1),
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF4F4F4F),
        ),
      ),
    );
  }
}
