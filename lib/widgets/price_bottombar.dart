import 'package:flutter/material.dart';
import 'package:size_config/util/size_extention.dart';
import '../common/styles.dart';

class PriceBottomBar extends StatelessWidget {
  const PriceBottomBar({
    required this.label,
    required this.price,
    required this.onTap,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  final String price;
  final String label;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: bottomShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Harga',
                    style: TextStyle(fontWeight: medium, fontSize: 12.sp),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontWeight: semiBold,
                      fontSize: 18.sp,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Color(0xffB1BBD4),
                        )
                      : Text(
                          label,
                          style: TextStyle(
                              color: Colors.white, fontWeight: semiBold),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
