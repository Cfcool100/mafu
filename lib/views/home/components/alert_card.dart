
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/utils/themes.dart';

class AlertInfosCard extends StatelessWidget {
  const AlertInfosCard({super.key, this.spaceBetween});

  final double? spaceBetween;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133.w,
      margin:
          EdgeInsets.symmetric(horizontal: spaceBetween ?? 15.w, vertical: 5.h),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: -1,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 73.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(30.r)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 11.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marché cocovico',
                  textAlign: TextAlign.start,
                  style: AppTheme.textBlackH6
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Text(
                  'Cocody, Abidjan',
                  style: AppTheme.textBlackH6
                      .copyWith(fontSize: 8.sp, fontWeight: FontWeight.w300),
                ),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '4.3 CM',
                      style: GoogleFonts.montserrat(fontSize: 14.sp),
                    ),
                    Text(
                      '23 min',
                      style: GoogleFonts.montserrat(fontSize: 14.sp),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
