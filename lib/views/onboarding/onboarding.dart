import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/widgets/button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Image.asset(
                    'images/Logo-white.png',
                    scale: 1,
                  ),
                  Text(
                    'Mafuriko',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFFFFF8F0),
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.36.sp,
                    ),
                  ),
                  Text(
                    'Surveillance en temps réel des inondations',
                    strutStyle: const StrutStyle(leading: 1),
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFFFFF8F0),
                      fontSize: 13.3.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  PrimaryButton(
                    onPressed: () {
                      context.pushNamed(Paths.register);
                    },
                    color: const Color(0xFF111D4A),
                    textColor: Colors.white,
                    title: 'Inscription',
                  ),
                  Gap(10.h),
                  PrimaryButton(
                    onPressed: () {
                      context.pushNamed(Paths.login);
                    },
                    title: 'Connexion',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                'by GEODAFTAR, 2023.',
                style: GoogleFonts.montserrat(fontSize: 13.sp),
              ),
            )
          ],
        )),
      ),
    );
  }
}
