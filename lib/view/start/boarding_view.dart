import 'package:flutter/material.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/widgets/reusable_button.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:size_config/util/size_extention.dart';

class BoardingView extends StatefulWidget {
  const BoardingView({Key? key}) : super(key: key);

  @override
  State<BoardingView> createState() => _BoardingViewState();
}

class _BoardingViewState extends State<BoardingView> {
  PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  final _title = [
    'Temukan passionmu',
    'Materi terupdate',
    'Jadikan portofoliomu'
  ];

  final _description = [
    'Tersedia berbagai macam bidang\npembelajaran yang bisa kamu coba dalami.',
    'Materi terstruktur dan ter-update\nmenyesuaikan perkembangan industri.',
    'Kamu dapat mengerjakan proyek\nsebagai portofolio dan mendapat sertifikat.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: 3,
          itemBuilder: (_, i) => Padding(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/illustration-${i + 1}.png',
                  height: 375.h,
                ),
                SizedBox(height: 24.h),
                Text(
                  _title[i],
                  style: TextStyle(
                    fontWeight: semiBold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  _description[i],
                  style: TextStyle(color: secondaryTextColor, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, j) => PaginationClip(i == j),
                    itemCount: 3,
                  ),
                ),
                SizedBox(height: 30.h),
                ReusableButton(
                  style: buttonStyle,
                  text: i == 2 ? 'Mulai' : 'Selanjutnya',
                  onPressed: () {
                    if (i == 2) {
                      Navigation.off('/login');
                    } else {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaginationClip extends StatelessWidget {
  const PaginationClip(this.isActive, {Key? key}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: isActive
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor)),
                ),
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            )
          : Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
    );
  }
}
