import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color primaryColor = const Color(0xFF111D4A);
  static Color secondaryColor = const Color(0xFF7A4419);
  static Color tertiaryColor = const Color(0xFFFFCF99);
  static TextStyle textH1 = GoogleFonts.montserrat(
    fontSize: 24.spMin,
    fontWeight: FontWeight.w600,
    color: secondaryColor,
  );
  static TextStyle regularTextH1 = GoogleFonts.montserrat(
    fontSize: 20.spMin,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle textH2 = GoogleFonts.montserrat(
    color: Colors.black,
    fontSize: 20.spMin,
    fontWeight: FontWeight.w500,
  );
  static TextStyle textH3 = GoogleFonts.montserrat();
  static TextStyle textH4 = GoogleFonts.montserrat();

  static TextStyle textSemiRegularH5 = GoogleFonts.montserrat(
    fontSize: 14.spMin,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  static TextStyle textSemiBoldH5 = GoogleFonts.montserrat(
    fontSize: 14.spMin,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle textH6 = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
  );
  static TextStyle textBlackH6 = GoogleFonts.montserrat(
    color: Colors.black,
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
  );
}
