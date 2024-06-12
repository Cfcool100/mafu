import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mafuriko/controllers/alert.controller.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/views/home/components/home_component.dart';
import 'package:mafuriko/widgets/section_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Alert.fetchAlert();
    getLocate();
  }

  double lat = 0;
  double lng = 0;
  Location location = Location();

  Future<void> getLocate() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((currentLocation) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          if (currentLocation.latitude != null &&
              currentLocation.longitude != null) {
            lat = currentLocation.latitude!;
            lng = currentLocation.longitude!;
            // print(':::::::::::::::::::::::::$currentLocation');
          }
        });
      }
    });
  }

  final ScrollController _controller = ScrollController();

  Future<List<FloodAlert>> getFloodAlerts() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? jsonString = pref.getString('FloodAlert');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      List<FloodAlert> alerts =
          jsonList.map((json) => FloodAlert.fromJson(json)).toList();
      return alerts;
    } else {
      return [];
    }
  }

  DateTime formatStringToDateTime(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }

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
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 18.w),
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            const SliverToBoxAdapter(child: Dashboard()),
            SliverGap(23.h),
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Actualités',
                width: 15.w,
              ),
            ),
            const SliverToBoxAdapter(
                child: CustomTiles(
              title: 'Entrer votre localisation',
              icon: Icons.navigate_next,
            )),
            SliverGap(8.0.h),
            SliverToBoxAdapter(
              child: CustomTiles(
                title: 'Zone sans danger',
                icon: Icons.check_box_outlined,
                color: Colors.green.shade400.withOpacity(.7),
              ),
            ),
            SliverGap(25.h),
            SliverToBoxAdapter(
              child: SectionTitle(
                title: 'Alertes récentes',
                width: 15.w,
              ),
            ),
            SliverGap(10.h),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 374.h,
                child: FutureBuilder<List<FloodAlert>>(
                  future: Alert.fetchAlert(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No Flood Alerts available');
                    } else {
                      List<FloodAlert> floodAlerts = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: floodAlerts.length,
                        itemBuilder: (context, index) {
                          int last = floodAlerts.length - 1 - index;
                          return AlertInfosCard(
                            style: style(floodAlerts[last].floodIntensity),
                            spaceBetween: index % 2 == 1 ? 15.w : 5.w,
                            scene: floodAlerts[last].floodLocation['latitude'],
                            intensity: floodAlerts[last].floodIntensity,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
