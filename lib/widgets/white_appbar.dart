import 'package:flutter/material.dart';

import '../common/styles.dart';

AppBar buildWhiteAppBar(String text) => AppBar(
      title: Text(
        text,
        style: appBarStyle.copyWith(color: primaryTextColor),
      ),
      titleTextStyle: appBarStyle,
      backgroundColor: Colors.white,
      foregroundColor: primaryTextColor,
    );
