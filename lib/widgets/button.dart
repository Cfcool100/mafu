import 'package:flutter/material.dart';
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
  });

  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? color;
  final String title;
  final double? size;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      disabledColor: Color(0xFF8380B6),
      disabledElevation: null,
      splashColor: color,
      onPressed: onPressed,
      focusColor: null,
      focusElevation: 0,
      minWidth: width ?? 350,
      color: (color != null) ? color : null,
      height: 45,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: (color != null) ? BorderSide.none : const BorderSide(),
      ),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
            fontSize: size ?? 15,
            fontWeight: (size != null) ? FontWeight.w600 : FontWeight.normal),
      ),
    );
  }
}
