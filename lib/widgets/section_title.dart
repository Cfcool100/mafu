import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/utils/themes.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    this.width,
    required this.title,
  });

  final double? width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.textH1.copyWith(fontSize: width ?? 22),
        ),
        Divider(
          thickness: 1,
          endIndent: MediaQuery.sizeOf(context).width * .72,
          color: AppTheme.secondaryColor,
        ),
      ],
    );
  }
}
