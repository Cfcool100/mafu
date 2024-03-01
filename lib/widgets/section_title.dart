import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          style: AppTheme.textH1.copyWith(fontSize: width == null? 22.sp : 14.sp),
        ),
        Divider(
          thickness: 1,
          endIndent: width == null? .72.sw : .80.sw,
          color: AppTheme.secondaryColor,
        ),
      ],
    );
  }
}
