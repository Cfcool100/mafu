import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/utils/elapsed_times.dart';
import 'package:mafuriko/utils/themes.dart';

class AlertInfosCard extends StatelessWidget {
  const AlertInfosCard({
    super.key,
    required this.data,
    required this.index,
  });

  final FloodAlert data;
  final int index;

  // int last = floodAlerts.length - 1 - index;

  TextStyle style(String intensity) {
    if (intensity == 'faible') {
      return GoogleFonts.montserrat(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.green.shade700);
    } else if (intensity == 'moyen') {
      return GoogleFonts.montserrat(
          fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.blue);
    } else {
      return GoogleFonts.montserrat(
          fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.w,
      margin: EdgeInsets.symmetric(
          horizontal: index % 2 == 1 ? 15.w : 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 1),
            spreadRadius: -1,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetFloodImage(
            img: data.floodImages,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.w, top: 30.h, right: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.floodScene}',
                  textAlign: TextAlign.start,
                  style: AppTheme.textBlackH6
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                ),
                Text(
                  'Cocody, Abidjan',
                  style: AppTheme.textBlackH6
                      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Gap(75.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.floodIntensity.toUpperCase(),
                      style: style(data.floodIntensity),
                    ),
                    Text(
                      formatElapsedTime(data.floodDate),
                      style: GoogleFonts.montserrat(fontSize: 14.sp),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FloodImage extends StatelessWidget {
  const FloodImage({super.key, this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    return image != null && image!.isNotEmpty
        ? Container(
            height: 181.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image!),
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(30.r)),
            ),
          )
        : NetFloodImage(img: image ?? '');
  }
}

class NetFloodImage extends StatelessWidget {
  const NetFloodImage({super.key, this.img, this.errorWidgetImage});
  final String? img, errorWidgetImage;

  @override
  Widget build(BuildContext context) {
    final validImg = img != null && img!.isNotEmpty;
    return validImg
        ? CachedNetworkImage(
            height: 181.h,
            imageUrl: img!,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 181.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(30.r)),
                ),
              );
            },
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SpinKitRing(
              color: Colors.blueAccent.shade100,
              size: 50.h,
              lineWidth: 3.5.w,
            ),
            errorWidget: (context, url, error) => _buildErrorWidget(context),
          )
        : _buildErrorWidget(context);
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      height: 181.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(errorWidgetImage ?? 'images/background.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r)),
      ),
    );
  }
}
