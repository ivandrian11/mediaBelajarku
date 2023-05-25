import 'package:flutter/material.dart';
import 'package:size_config/util/size_extention.dart';
import '../common/styles.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.percentage,
    required this.height,
    this.backgroundColor = const Color(0xffDBE1F1),
    this.valueColor = primaryColor,
    this.labelColor = secondaryTextColor,
  }) : super(key: key);

  final double percentage;
  final double height;
  final Color backgroundColor;
  final Color valueColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(valueColor),
              value: percentage,
              minHeight: height.h,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        SizedBox(
          width: 28.w,
          child: Text(
            "${(percentage * 100).toInt()}%",
            style: TextStyle(
              fontSize: 12.sp,
              color: labelColor,
            ),
          ),
        ),
      ],
    );
  }
}
