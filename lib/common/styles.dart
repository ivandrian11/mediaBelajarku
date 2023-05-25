import 'package:flutter/material.dart';
import 'package:size_config/util/size_extention.dart';

// * Color
const backgroundColor = Color(0xffF6F8FD);
const primaryTextColor = Color(0xff323232);
const secondaryTextColor = Color(0xff777986);
const primaryColor = Color(0xff4B6ABB);

// * Margin
var margin = 16.0.w;

// * Font Weight
const normal = FontWeight.w400;
const medium = FontWeight.w500;
const semiBold = FontWeight.w600;

// * Shadow
var cardShadow = [
  BoxShadow(
    blurRadius: 5,
    offset: Offset(0, 1),
    color: Color(0xff000000).withOpacity(0.15),
  ),
];

var bottomShadow = [
  BoxShadow(
    blurRadius: 4,
    offset: Offset(0, -1),
    color: Color(0xff000000).withOpacity(0.15),
  ),
];

// * Style
var standardStyle = TextStyle(fontSize: 14.sp);
var buttonStyle = TextStyle(fontSize: 14.sp, fontWeight: semiBold);
var appBarStyle = TextStyle(fontSize: 18.sp, fontWeight: medium);
var titleStyle = TextStyle(fontSize: 18.sp, fontWeight: semiBold);
var subtitleStyle = TextStyle(fontSize: 16.sp, fontWeight: semiBold);
var descriptionStyle = TextStyle(color: secondaryTextColor, height: 1.6);
var summaryStyle = TextStyle(color: secondaryTextColor, fontSize: 14.sp);
