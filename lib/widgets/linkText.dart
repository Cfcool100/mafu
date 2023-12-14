import 'package:flutter/material.dart';
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
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, link);
          },
          child: Column(
            children: [
              Text(
                textLink,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF7A4419),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  // decoration: TextDecoration.underline,
                ),
              ),
              Container(
                height: 1,
                width: lineSize ?? 85,
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
