import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> _markers = [];
  List<Circle> _circles = [];

  String theme = '';
  Location location = Location();

  bool isLoad = false;
  bool showTheme = false;
  double zoom = 15;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng currentPosition = const LatLng(0.393037, 9.450152);

  @override
  void initState() {
    super.initState();
    getLocate();

    getFloodAlerts();
    DefaultAssetBundle.of(context)
        .loadString('g_map_theme/normal_theme.json')
        .then((value) {
      theme = value;
      debugPrint(theme);
    });
  }

  Future<void> getFloodAlerts() async {
    /// - recuperation de la liste d'articles dans le cache du telephone
    ///
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? jsonString = pref.getString('FloodAlert');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      /// - nommer la liste d'alerte "alerts"

      List<FloodAlert> alerts =
          jsonList.map((json) => FloodAlert.fromJson(json)).toList();
      debugPrint(':::::::::::::::::::::::::${alerts.length} alerts found');

      /// - faire une boucle for sur alerts :

      setState(() {
        _markers = alerts.map((alert) {
          return Marker(
            markerId: MarkerId(
                'alert_${alert.floodLocation['latitude']}_${alert.floodLocation['longitude']}'),
            position: LatLng(
              double.parse(alert.floodLocation['latitude']!),
              double.parse(alert.floodLocation['longitude']!),
            ),
            infoWindow: InfoWindow(
                title: ' ${alerts.first.floodIntensity}',
                snippet: alert.floodDescription),
          );
        }).toList();
        _circles = alerts
            .map((alert) => Circle(
                  circleId: CircleId(
                      'alert_${alert.floodLocation['latitude']}_${alert.floodLocation['longitude']}'),
                  center: LatLng(
                    double.parse(alert.floodLocation['latitude']!),
                    double.parse(alert.floodLocation['longitude']!),
                  ),
                  radius: 100.r,
                  strokeColor: Colors.redAccent.shade100,
                  fillColor: Colors.redAccent.shade100,
                ))
            .toList();
      });
    } else {
      debugPrint('::::::::::::::::::::::::: No alerts found in cache');
    }
  }

  Future<void> getLocate() async {
    setState(() {
      isLoad = true;
    });
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
            isLoad = false;
            currentPosition =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);

            // debugPrint(':::::::::::::::::::::::::$currentLocation');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? Stack(
              children: [
                Center(
                  child: SpinKitCubeGrid(
                    color: Colors.blueAccent.shade100,
                    size: 50.h,
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                GoogleMap(
                  key: ValueKey(isLoad),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: currentPosition,
                    zoom: zoom,
                  ),
                  style: theme,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: _markers.toSet(),
                  circles: _circles.toSet(),
                ),
                showTheme
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 70.w, bottom: 150.h),
                          child: Container(
                            width: 100,
                            color: theme == ''
                                ? const Color(0xFF1D1B31)
                                : Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(
                                    'Normal',
                                    style: GoogleFonts.montserrat(
                                        color: theme != ''
                                            ? const Color(0xFF1D1B31)
                                            : Colors.white,
                                        fontSize: 16.sp),
                                  ),
                                  onTap: () => setState(() {
                                    theme = '';
                                    showTheme = false;
                                  }),
                                ),
                                ListTile(
                                  title: Text(
                                    'night',
                                    style: GoogleFonts.montserrat(
                                        color: theme != ''
                                            ? const Color(0xFF1D1B31)
                                            : Colors.white,
                                        fontSize: 16.sp),
                                  ),
                                  onTap: () => setState(() {
                                    _controller.future.then((value) {
                                      DefaultAssetBundle.of(context)
                                          .loadString(
                                              'g_map_theme/blue_theme.json')
                                          .then((night) {
                                        theme = night;
                                      });
                                      showTheme = false;
                                    });
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 34.h),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                              hintText: "Search for your localisation",
                              suffixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 35.w,
                          padding: EdgeInsets.only(right: 5.w, left: 3.w),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    debugPrint('stack_line');
                                    setState(() {
                                      showTheme = true;
                                    });
                                  },
                                  icon: const Icon(FlutterRemix.stack_line)),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  debugPrint('send_plane_line');
                                },
                                icon: const Icon(FlutterRemix.send_plane_line),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  getLocate();
                                  debugPrint('search_2_line');
                                },
                                icon: const Icon(FlutterRemix.search_2_line),
                              ),
                            ],
                          ),
                        ),
                        Gap(25.h),
                        Container(
                          width: 35.w,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      zoom = zoom + 1;
                                    });
                                    debugPrint('add $zoom');
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                                Container(
                                  height: .3,
                                  width: 15,
                                  color: Colors.black,
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    debugPrint('minus');
                                    setState(() {
                                      zoom = zoom - 1;
                                    });

                                    debugPrint('add');
                                  },
                                  icon: const Icon(CupertinoIcons.minus),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
