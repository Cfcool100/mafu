import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mafuriko/models/alert.models.dart';

import 'package:mafuriko/widgets/section_title.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({
    super.key,
    required this.alert,
  });

  final FloodAlert alert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.h),
        child: AppBar(
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: CupertinoColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 390.w,
              height: 268.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: CachedNetworkImage(
                      imageUrl: '${alert.floodImages}',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 390.w,
                          height: 268.h,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SpinKitRing(
                        color: Colors.blueAccent.shade100,
                        size: 50.h,
                        lineWidth: 3.5.w,
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 390.w,
                        height: 268.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'images/background.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 18.h),
                      child: Text(
                        '${alert.floodScene}, Cocody, Abidjan',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFFFBFBFB),
                          fontSize: 12.sp,
                          // backgroundColor: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 52.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Icon(
                        Icons.menu_rounded,
                        size: 35,
                      ),
                      Text('4,5 cm'),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(
                        FlutterRemix.calendar_line,
                        size: 30,
                      ),
                      Text(DateFormat('d MMM. yyyy')
                          .format(DateTime.parse(alert.floodDate))),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(
                        CupertinoIcons.clock,
                        size: 32,
                      ),
                      Text(DateFormat('HH:mm')
                          .format(DateTime.parse(alert.floodDate))),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 20.h),
              child: SectionTitle(
                title: 'Informations générales',
                width: 15.w,
              ),
            ),
            SizedBox(
              height: 50.h,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Intensité de l’inondation',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Text(
                    alert.floodIntensity,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF111D4A),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Description de l’inondation',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 0.16,
                ),
              ),
              subtitle: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                margin: EdgeInsets.only(top: 10.h),
                color: const Color(0x9ED9D9D9),
                child: Text(
                  alert.floodDescription ?? 'N/A',
                  // textAlign: TextAlign.,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF111D4A),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 30.h),
              child: SectionTitle(
                title: 'Informations techniques',
                width: 15.w,
              ),
            ),
            ListTile(
              title: Text(
                'Coordonnées géographiques',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 0.16,
                ),
              ),
              trailing: Text(
                alert.floodLocation.values.toString().substring(
                    1, alert.floodLocation.values.toString().length - 1),
                textAlign: TextAlign.right,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF111D4A),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 0.16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
