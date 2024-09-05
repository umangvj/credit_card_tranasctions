import 'package:credit_card_transactions/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class GradientViewer extends StatelessWidget {
  const GradientViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Less',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 9,
            ),
          ),
          const SizedBox(width: 4),
          GradientContainer(
            color: Colors.grey.shade900,
            height: 13,
            width: 13,
          ),
          const GradientContainer(
            gradient: ColorConstants.gradient1,
          ),
          const GradientContainer(
            gradient: ColorConstants.gradient2,
          ),
          const GradientContainer(
            gradient: ColorConstants.gradient3,
          ),
          const GradientContainer(
            gradient: ColorConstants.gradient4,
          ),
          const SizedBox(width: 4),
          Text(
            'More',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    this.gradient,
    this.color,
    this.height,
    this.width,
    super.key,
  });

  final Gradient? gradient;
  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 12,
      width: width ?? 12,
      margin: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
