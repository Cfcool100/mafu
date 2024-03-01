import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color,
    this.textColor,
    this.size,
    this.width,
    this.status,
  });

  final VoidCallback? onPressed;
  final Color? textColor;
  final FormzSubmissionStatus? status;
  final Color? color;
  final String title;
  final double? size;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      disabledColor: const Color(0xFF8380B6),
      disabledElevation: null,
      splashColor: color,
      onPressed: status != null && status!.isInProgress ? null : onPressed,
      focusColor: null,
      focusElevation: 0,
      minWidth: width ?? 322.w,
      color: (color != null) ? color : null,
      height: 40.h,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.r),
        side: (color != null) ? BorderSide.none : const BorderSide(),
      ),
      child: status != null && status!.isInProgress
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: size ?? 15.sp,
                  fontWeight:
                      (size != null) ? FontWeight.w600 : FontWeight.normal),
            ),
    );
  }
}
