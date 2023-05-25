import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:size_config/util/size_extention.dart';

class StatusOrderView extends StatefulWidget {
  final String status;
  const StatusOrderView(this.status, {Key? key}) : super(key: key);

  @override
  State<StatusOrderView> createState() => _StatusOrderViewState();
}

class _StatusOrderViewState extends State<StatusOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      widget.status == "success"
                          ? 'assets/lottie/payment-success.json'
                          : 'assets/lottie/payment-failed.json',
                      height: 280.h,
                    ),
                    Text(
                      widget.status == "success"
                          ? "Hoorayy!!"
                          : "Upss, Sorry...",
                      style: titleStyle,
                    ),
                    SizedBox(height: 8.h),
                    RichText(
                      textScaleFactor: 1.15,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Your payment is ',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: widget.status == "success"
                                ? "success"
                                : "failed",
                            style: TextStyle(
                              color: widget.status == "success"
                                  ? Colors.greenAccent[400]
                                  : Colors.redAccent[400],
                              fontWeight: semiBold,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextSpan(
                            text: widget.status == "success"
                                ? ". You can\nstart to learn your course now. "
                                : ". You can\ntry to order again next time. ",
                            style: TextStyle(
                                color: primaryTextColor, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ReusableButton(
                      isPrimary: false,
                      text: "Back to Home",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: semiBold,
                      ),
                      onPressed: () => Navigation.offAll('/main')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
