import 'package:flutter/material.dart';
import 'package:size_config/util/size_extention.dart';
import '/common/styles.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    required this.text,
    required this.onPressed,
    required this.style,
    this.isLoading = false,
    this.height = 45,
    this.isPrimary = true,
    Key? key,
  }) : super(key: key);

  final bool isLoading;
  final String text;
  final Function() onPressed;
  final double height;
  final TextStyle style;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? isLoading
                  ? primaryColor.withOpacity(.2)
                  : primaryColor
              : Colors.transparent,
          elevation: 0,
          side: isPrimary ? null : BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: Size(double.infinity, height.h)),
      child: isLoading ? CircularProgressIndicator() : Text(text, style: style),
      onPressed: onPressed,
    );
  }
}
