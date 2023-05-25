import 'package:flutter/material.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:size_config/util/size_extention.dart';

class FieldNonPassword extends StatelessWidget {
  const FieldNonPassword({
    required this.controller,
    required this.label,
    required this.icon,
    this.isEnabled = true,
    this.isLastField = false,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final Icon icon;
  final bool isEnabled;
  final bool isLastField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4.h),
        TextField(
          controller: controller,
          enabled: isEnabled,
          autocorrect: false,
          keyboardType: label == 'Email'
              ? TextInputType.emailAddress
              : TextInputType.text,
          textInputAction:
              isLastField ? TextInputAction.done : TextInputAction.next,
          style: standardStyle,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 16.w,
            ),
            hintText: 'Masukkan ${label.toLowerCase()}',
            hintStyle: standardStyle,
            prefixIcon: icon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
