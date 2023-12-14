import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.title,
    required this.hint,
    required this.onChanged,
    required this.type,
    this.obscure,
    this.width,
    this.height,
    this.maxLine,
  });

  final String title;
  final String hint;
  final TextInputType type;
  final bool? obscure;
  final double? width;
  final double? height;
  final int? maxLine;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const Gap(10),
        Form(
          child: Container(
            height: height ?? 40,
            width: width,
            padding: EdgeInsets.only(bottom: 10),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: TextField(
              onChanged: onChanged,
              keyboardType: type,
              obscureText: obscure ?? false,
              maxLines: maxLine ?? 1,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                contentPadding:
                    const EdgeInsets.only(left: 20.0, bottom: 12, top: 0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
