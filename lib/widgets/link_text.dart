import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkText extends StatelessWidget {
  const LinkText({
    super.key,
    this.text,
    this.lineSize,
    required this.textLink,
    required this.link,
  });

  final String? text;
  final String textLink;
  final String link;
  final double? lineSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text!,
          style: GoogleFonts.montserrat(
            color: const Color(0xFF171725),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(link);
          },
          child: Column(
            children: [
              Text(
                textLink,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF7A4419),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  // decoration: TextDecoration.underline,
                ),
              ),
              Container(
                height: .5.h,
                width: lineSize ?? 85.spMin,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(),
                  color: Color(0xFF7A4419),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
