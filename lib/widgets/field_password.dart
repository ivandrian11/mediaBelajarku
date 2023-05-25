import 'package:flutter/material.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:size_config/util/size_extention.dart';

class FieldPassword extends StatelessWidget {
  const FieldPassword({
    required this.controller,
    required this.isObscure,
    required this.onPressed,
    this.label = "Password",
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool isObscure;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4.h),
        TextField(
          controller: controller,
          autocorrect: false,
          obscureText: isObscure,
          style: standardStyle,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 16.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            hintText: 'Masukkan password',
            hintStyle: standardStyle,
            prefixIcon: Icon(Icons.lock, size: 24.h),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(
                isObscure ? Icons.visibility : Icons.visibility_off,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
