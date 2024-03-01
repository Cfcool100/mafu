import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/utils/themes.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        border: const Border(),
        borderRadius: BorderRadius.circular(5.r),
        color: AppTheme.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '20º',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 24.spMin,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    CupertinoIcons.sun_haze,
                    color: Colors.white,
                  ),
                  Gap(5.w),
                  Text(
                    'Ensoleillé',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12.spMin,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Cocody, Abidjan',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(5.h),
              Text(
                'Ensoleillé',
                textAlign: TextAlign.end,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Gap(10.h),
            ],
          ),
        ],
      ),
    );
  }
}
