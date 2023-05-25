import 'package:flutter/material.dart';
import 'package:size_config/util/size_extention.dart';
import '../common/styles.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 153.h,
      color: primaryColor,
      child: Stack(
        children: [
          Image.asset(
            'assets/img/lines.png',
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: margin),
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: semiBold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
