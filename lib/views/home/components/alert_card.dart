import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/utils/elapsed_times.dart';
import 'package:mafuriko/utils/themes.dart';

class AlertInfosCard extends StatelessWidget {
  const AlertInfosCard(
      {super.key,
      this.spaceBetween,
      this.scene,
      this.intensity,
      this.postDate,
      this.style});

  final double? spaceBetween;
  final String? scene;
  final String? intensity;
  final String? postDate;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.w,
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
            height: 181.h,
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
            padding: EdgeInsets.only(left: 18.w, top: 30.h, right: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$scene',
                  textAlign: TextAlign.start,
                  style: AppTheme.textBlackH6
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                ),
                Text(
                  'Cocody, Abidjan',
                  style: AppTheme.textBlackH6
                      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Gap(75.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${intensity?.toUpperCase()}',
                      style: style ?? GoogleFonts.montserrat(fontSize: 14.sp),
                    ),
                    Text(
                      formatElapsedTime(postDate ?? ''),
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
