import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

List<SalomonBottomBarItem> navBar(int index) => [
      SalomonBottomBarItem(
        icon: Container(
          width: 70.w,
          padding: EdgeInsets.only(left: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FlutterRemix.home_line),
              Text(
                "Home",
                style: GoogleFonts.montserrat(
                  color: index == 0
                      ? const Color(0xFFE77A00)
                      : AppTheme.primaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        title: const Text(""),
        selectedColor: const Color(0xFFE77A00),
      ),
      SalomonBottomBarItem(
        icon: Container(
          width: 70.w,
          padding: EdgeInsets.only(left: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FlutterRemix.map_2_line),
              Text(
                "Carte",
                style: GoogleFonts.montserrat(
                  color: index == 1
                      ? const Color(0xFFE77A00)
                      : AppTheme.primaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        title: const Text(""),
        selectedColor: const Color(0xFFE77A00),
      ),
      SalomonBottomBarItem(
        icon: Container(
          width: 70.w,
          padding: EdgeInsets.only(left: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FlutterRemix.stack_line),
              Text(
                "Données",
                style: GoogleFonts.montserrat(
                  color: index == 2
                      ? const Color(0xFFE77A00)
                      : AppTheme.primaryColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        title: const Text(""),
        selectedColor: const Color(0xFFE77A00),
      ),
    ];
