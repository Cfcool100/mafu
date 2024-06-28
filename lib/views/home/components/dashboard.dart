import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/providers/profile/profile_bloc.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/utils/themes.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(const ProfileUpdateEvent()),
      child: Container(
        width: 1.sw,
        height: 85.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          border: const Border(),
          borderRadius: BorderRadius.circular(5.r),
          color: AppTheme.primaryColor,
        ),
        child: GestureDetector(
          onTap: () {
            context.pushNamed(Paths.profile);
            context.read<ProfileBloc>().add(const ProfileUpdateEvent());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.tertiaryColor,
                    child: const Icon(FlutterRemix.user_3_line),
                  ),
                  Gap(5.h),
                  Text(
                    'Profile',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )
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
        ),
      ),
    );
  }
}
