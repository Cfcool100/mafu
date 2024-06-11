import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    this.title,
    required this.type,
    this.hint,
    this.onChanged,
    this.controller,
    this.obscure,
    this.enable,
    this.width,
    this.height,
    this.maxLine,
    this.errorText,
    this.validator,
  });

  final String? title;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType type;
  final bool? obscure;
  final bool? enable;
  final double? width;
  final double? height;
  final int? maxLine;
  final String? errorText;
  final Function(String value)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Gap(8.h),
        Container(
          height: height ?? 40.h,
          width: width,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.r),
            ),
            color: title != null ? null : Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: type,
            obscureText: obscure ?? false,
            maxLines: maxLine ?? 1,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              enabled: enable ?? true,
              hintText: hint,
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
              contentPadding:
                  EdgeInsets.only(left: 15.w, bottom: 11..w, top: 2.h),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 2.h),
          child: errorText != null
              ? Text(
                  "$errorText",
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
