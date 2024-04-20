import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color backgroundColor =
      Color(0xFFF6F8FA); // Define your background color
  static const Color secondaryBackgroundColor = Color.fromARGB(
      255, 242, 243, 244); // Define your secondary background color
  static const Color blackColor = Color(0xFF1D1E26); // Define your black color
  static const Color linkColor = Color(0xFF438CFD); // Define your link color
  static const whiteColor = Color.fromARGB(255, 255, 255, 255);
  static const Color greyColor = Color(0xFF8593A2);
}

TextStyle montserratTextStyle(
  Color textColor,
  double fontSize,
  FontWeight FontWeight,
) {
  return GoogleFonts.lato(
    color: textColor,
    fontSize: fontSize,
    fontWeight: FontWeight,
  );
}

String DateToday() {
  int day = DateTime.now().day;
  String suffix = '';
  if (day >= 11 && day <= 13) {
    suffix = 'th';
  } else {
    switch (day % 10) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
  }

  return DateFormat('EEEE, MMMM dd').format(DateTime.now()) + suffix;
}
