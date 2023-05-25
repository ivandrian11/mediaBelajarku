import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/course.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/data/model/user.dart';
import 'package:media_belajarku/view_model/order_vm.dart';
import 'package:media_belajarku/view_model/promo_vm.dart';
import 'package:media_belajarku/view_model/user_vm.dart';
import 'package:media_belajarku/widgets/price_bottombar.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';

class TransactionView extends StatefulWidget {
  final Course course;

  const TransactionView(this.course, {Key? key}) : super(key: key);

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PromoVM>(
      builder: (context, promoP, _) {
        int total = promoP.selected != null
            ? (widget.course.price - promoP.selected!.discount) > 0
                ? (widget.course.price - promoP.selected!.discount)
                : 0
            : widget.course.price;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('Transaksi'), titleTextStyle: appBarStyle),
          bottomNavigationBar: Consumer<OrderVM>(builder: (context, orderP, _) {
            User user =
                Provider.of<UserVM>(context, listen: false).response.data;

            return PriceBottomBar(
                isLoading: orderP.isLoading,
                price: total > 0 ? rupiahFormating(total) : 'Free',
                label: 'Lanjutkan',
                onTap: () {
                  showDialogConfirmation(() {
                    Navigation.back();
                    if (promoP.selected != null) {
                      orderP
                          .processOrder(
                        user.data.username,
                        widget.course.id,
                        total,
                        promoP.selected!.id,
                      )
                          .then((value) {
                        promoP.updateLimitPromo(promoP.selected!.id);
                        Timer(Duration(seconds: 1),
                            () => promoP.selectAPromo(null));
                      });
                    } else {
                      orderP
                          .processOrder(
                            user.data.username,
                            widget.course.id,
                            total,
                          )
                          .then((value) => Timer(Duration(seconds: 1),
                              () => promoP.selectAPromo(null)));
                    }
                  });
                });
          }),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                // ? Card
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: cardShadow,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.course.photoUrl,
                            fit: BoxFit.cover,
                            height: 100.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.course.name,
                              style: TextStyle(fontWeight: semiBold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              widget.course.mentor.name,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: secondaryTextColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              rupiahFormating(widget.course.price),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: primaryColor,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // ? Promo Container
                Text('Promo', style: subtitleStyle),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: secondaryTextColor),
                  ),
                  child: ListTile(
                    onTap: () => Navigation.intent('/promo'),
                    horizontalTitleGap: 0,
                    leading: Icon(
                      Icons.loyalty,
                      color: primaryColor,
                    ),
                    title: Text(
                      promoP.selected != null
                          ? 'Promo digunakan'
                          : 'Pilih Promo',
                      style: TextStyle(
                        color: promoP.selected != null
                            ? primaryColor
                            : secondaryTextColor,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 20.h),
                  ),
                ),
                SizedBox(height: 24.h),

                // ? Info
                Text('Info Pemesanan', style: subtitleStyle),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal', style: summaryStyle),
                    Text(
                      rupiahFormating(widget.course.price),
                      style: summaryStyle,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Diskon', style: summaryStyle),
                    Text(
                        promoP.selected != null
                            ? "-${rupiahFormating(promoP.selected!.discount)}"
                            : '0',
                        style: summaryStyle),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Biaya penanganan', style: summaryStyle),
                    Text('0', style: summaryStyle),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: subtitleStyle),
                    Text(rupiahFormating(total), style: subtitleStyle),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
