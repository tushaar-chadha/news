import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color backgroundColor =
      Color(0xFFF6F8FA); // Define your background color
  static const Color secondaryBackgroundColor =
      Color(0xFFF2F3F4); // Define your secondary background color
  static const Color blackColor = Color(0xFF1D1E26); // Define your black color
  static const Color linkColor = Color(0xFF438CFD); // Define your link color
  static const whiteColor = Color.fromARGB(255, 255, 255, 255);
}

TextStyle montserratNormal(
  Color textColor,
  double fontSize, FontWeight normal,

) {
  return GoogleFonts.montserrat(
    color: textColor,
    fontSize: fontSize,
    fontWeight: FontWeight.normal,
  );
}

TextStyle montserrat400(
  Color textColor,
  double fontSize,
) {
  return montserratNormal(textColor, fontSize, FontWeight.w400);
}

TextStyle montserrat500(
  Color textColor,
  double fontSize,
) {
  return montserratNormal(textColor, fontSize, FontWeight.w500);
}

TextStyle montserrat600(
  Color textColor,
  double fontSize,
) {
  return montserratNormal(textColor, fontSize, FontWeight.w600);
}

TextStyle montserrat700(
  Color textColor,
  double fontSize,
) {
  return montserratNormal(textColor, fontSize, FontWeight.w700);
}
