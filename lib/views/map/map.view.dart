import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    getLocate();
    location;
  }

  Location location = Location();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng _kGooglePlex = LatLng(0.393037, 9.450152);
  static const LatLng _kGooglePlex2 = LatLng(0.393037, 9.490152);
  static const LatLng _kGooglePlex3 = LatLng(0.353037, 9.480152);
  static const LatLng _kGooglePlex4 = LatLng(0.363037, 9.50552);

  // static const LatLng _kApplePark = LatLng(5.372475, -4.020844);

  late LatLng currentPosition;

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
            currentPosition =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: currentPosition,
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              const Marker(
                markerId: MarkerId('user'),
                position: _kGooglePlex,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                    title: 'TEst', snippet: 'forte intensité d\'innondation'),
              ),
              const Marker(
                markerId: MarkerId('user2'),
                position: _kGooglePlex2,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                    title: 'TEst', snippet: 'forte intensité d\'innondation'),
              ),
              const Marker(
                markerId: MarkerId('user3'),
                position: _kGooglePlex3,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                    title: 'TEst', snippet: 'forte intensité d\'innondation'),
              ),
              const Marker(
                markerId: MarkerId('user4'),
                position: _kGooglePlex4,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                    title: 'TEst', snippet: 'forte intensité d\'innondation'),
              ),
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 34.h),
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
              padding: EdgeInsets.only(right: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30.w,
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
                            onPressed: () {},
                            icon: const Icon(FlutterRemix.stack_line)),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(FlutterRemix.send_plane_line),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(FlutterRemix.search_2_line),
                        ),
                      ],
                    ),
                  ),
                  Gap(25.h),
                  Container(
                    width: 30.w,
                    padding: EdgeInsets.symmetric(vertical: 5.h),
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
                          InkWell(
                            onTap: () {},
                            child: const Icon(Icons.add),
                          ),
                          Divider(
                            indent: 5.w,
                            endIndent: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: const Icon(CupertinoIcons.minus),
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
