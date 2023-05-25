import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:size_config/util/size_extention.dart';
import 'package:intl/intl.dart';
import 'package:media_belajarku/common/navigation.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:media_belajarku/global.dart';

String rupiahFormating(int price) =>
    NumberFormat.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp ')
        .format(price);

void showErrorMessage(String message) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      elevation: 0,
      duration: Duration(milliseconds: 800),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red[800],
      content: Text(message, style: standardStyle),
    ),
  );
}

void showSuccessMessage(String message) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      elevation: 0,
      duration: Duration(milliseconds: 800),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[800],
      content: Text(message, style: standardStyle),
    ),
  );
}

void showDialogConfirmation(Function() onPressed) {
  showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmation', style: TextStyle(fontWeight: semiBold)),
          content: Text('Are your sure to continue?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigation.back(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text('Yes'),
            )
          ],
        );
      });
}

void showDialogInformation() {
  showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text('Information', style: TextStyle(fontWeight: semiBold)),
          content: Text(
            'Media Belajarku adalah sebuah media belajar berbasis online. Media Belajarku memiliki harapan besar berdiri untuk menyediakan media belajar yang berbasis digital seperti kursus online, ebook online, audio online dan mungkin akan muncul teknologi sebagai media untuk belajar.',
            style: standardStyle,
          ),
        );
      });
}

Widget missingIllustration(double height) => illustrationWidget(
      height,
      'assets/img/search_illustration.svg',
      'Sorry we couldn’t find\nany matches',
    );

Widget emptyIllustrationCourse(double height) => illustrationWidget(
      height,
      'assets/img/empty_illustration.svg',
      'You dont have any course',
    );

Widget emptyIllustrationOrder(double height) => illustrationWidget(
      height,
      'assets/img/empty_illustration.svg',
      'You dont have any order',
    );

Widget illustrationWidget(double height, String path, String text) => Center(
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              path,
              height:
                  path == 'assets/img/search_illustration.svg' ? 100.h : 150.h,
            ),
            SizedBox(height: 24.h),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
