import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0XFF6F35A5);
const Color kPrimaryLightColor = Color(0XFFF1E6FF);

const Color kBlueClr = Colors.blue;
const Color kDarkGreyClr = Color(0xFF121212);
const Color darkHeader = Color(0xFF424242);

const Color bluishClr = Color.fromARGB(255, 45, 2, 131);
const Color pinkClr = Colors.pink;
const Color yellowClr = Colors.yellow;

// TextStyle
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: Dimensions.fontSize20,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
  ));
}

// TextStyle Header
TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: (Dimensions.fontSize20 * 2) - 10, //40-10=30
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

// TextStyle title
TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: Dimensions.fontSize20 - 4,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

// TextStyle subTitle
TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: Dimensions.fontSize20 - 6,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
  ));
}
