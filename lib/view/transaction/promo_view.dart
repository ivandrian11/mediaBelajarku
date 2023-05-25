import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/data/api/api_response.dart';
import 'package:media_belajarku/data/helper/helper.dart';
import 'package:media_belajarku/data/model/promo.dart';
import 'package:media_belajarku/view_model/promo_vm.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:provider/provider.dart';
import 'package:size_config/util/size_extention.dart';

class PromoView extends StatefulWidget {
  const PromoView({Key? key}) : super(key: key);

  @override
  State<PromoView> createState() => _PromoViewState();
}

class _PromoViewState extends State<PromoView> {
  final promoC = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      final provider = Provider.of<PromoVM>(context, listen: false);
      provider.fetchAllPromo();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    promoC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Promo'), titleTextStyle: appBarStyle),
      body: Consumer<PromoVM>(
        builder: (context, provider, _) {
          switch (provider.response.status) {
            case Status.initial:
              return Center(
                child: Text('Fetching data...', style: standardStyle),
              );
            case Status.loading:
              return Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(
                child: Text(
                  provider.response.message!,
                  style: standardStyle,
                  textAlign: TextAlign.center,
                ),
              );
            case Status.completed:
              List<Promo> promos = [];
              promos.addAll(provider.response.data);
              promos.retainWhere((e) => e.available);
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: margin),
                children: [
                  SizedBox(height: 24.h),
                  // ? Field
                  SizedBox(
                    height: 45.h,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: TextField(
                            controller: promoC,
                            autocorrect: false,
                            style: standardStyle,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 16.w,
                              ),
                              hintText: 'Masukkan kode promo',
                              hintStyle: standardStyle,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Flexible(
                          child: ReusableButton(
                            style: buttonStyle,
                            text: 'Cek',
                            onPressed: () {
                              List<Promo> filter = [];
                              filter.addAll(provider.response.data);
                              filter.retainWhere((e) =>
                                  e.id.toLowerCase() ==
                                  promoC.text.toLowerCase());
                              if (filter.isEmpty) {
                                showErrorMessage(
                                    "the coupon code entered is not valid");
                              } else {
                                if (filter[0].limit == 0) {
                                  showErrorMessage(
                                      "the coupon code entered is expired");
                                } else {
                                  provider.selectAPromo(filter[0]);
                                  Navigation.back();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text('Pilih Promo', style: subtitleStyle),
                  SizedBox(height: 12.h),
                  // ? Promo Card
                  Column(
                    children: promos
                        .map(
                          (e) => PromoContainer(e, onPressed: () {
                            provider.selectAPromo(e);
                            Navigation.back();
                          }),
                        )
                        .toList(),
                  )
                ],
              );
          }
        },
      ),
    );
  }
}

class PromoContainer extends StatelessWidget {
  final Promo promo;
  final Function() onPressed;

  const PromoContainer(
    this.promo, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: cardShadow,
      ),
      child: Row(
        children: [
          Container(
            height: 64.h,
            width: 36.w,
            child: Icon(Icons.loyalty, color: Colors.white, size: 20.h),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          promo.id,
                          style: TextStyle(
                            fontWeight: semiBold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          promo.description,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: ReusableButton(
                      onPressed: onPressed,
                      text: 'Pakai',
                      height: 36,
                      style: TextStyle(
                        fontWeight: semiBold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
