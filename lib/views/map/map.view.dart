import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mafuriko/controllers/g_place.controller.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/routes/constants.dart';
import 'package:mafuriko/utils/themes.dart';
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
  double zoom = 15.0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final _customInfoWindowController = CustomInfoWindowController();
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  final PlaceService _placeService =
      PlaceService('AIzaSyAxtdCodXhHS0rd8MbX61O28jKuDlLRFUY');

  List<Map<String, dynamic>> _suggestions = []; // List to hold the suggestions

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

    _searchController.addListener(_onSearchChanged);
  }

  Future<void> getFloodAlerts() async {
    /// - recuperation de la liste d'articles dans le cache du telephone
    ///
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? jsonString = pref.getString('FloodAlert');

    debugPrint(
        'recuperation de la liste d\'articles dans le cache du telephone $jsonString');
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
            // infoWindow: InfoWindow(
            //   title: ' ${alerts.first.floodIntensity}',
            //   snippet: alert.floodDescription,
            // ),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                GestureDetector(
                  onTap: () =>
                      context.pushNamed(Paths.alertDetail, extra: alert),
                  child: Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${alert.floodImages}',
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 120.h,
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.r),
                                  topRight: Radius.circular(15.r),
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
                            height: 120.h,
                            margin: EdgeInsets.only(bottom: 12.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r),
                              ),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'images/background.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 12.h),
                        //   height: 120.h,
                        //   decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(15.r),
                        //   topRight: Radius.circular(15.r),
                        // ),
                        //     color: Colors.blue,
                        //     image: DecorationImage(
                        //       image: NetworkImage(alert.floodImages ??
                        //           "https://propay-storage.ams3.digitaloceanspaces.com/alerts/1719602545887"),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              Text(
                                alert.floodDescription ?? 'N/A',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                alert.floodScene ?? 'N/A',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.urbanist(
                                  fontSize: 14.sp,
                                  color: alert.floodScene != null
                                      ? AppTheme.primaryColor
                                      : AppTheme.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                LatLng(
                  double.parse(alert.floodLocation['latitude']!),
                  double.parse(alert.floodLocation['longitude']!),
                ),
              );
            },
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

  Future<void> recenter() async {
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();

      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        final LatLng currentPosition = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );

        // Déplacer la caméra vers la position actuelle
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: currentPosition,
              zoom: 15.0, // Vous pouvez ajuster le niveau de zoom si nécessaire
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la position: $e');
    }
  }

  void _onSearchChanged() async {
    if (_searchController.text.isNotEmpty) {
      final suggestions =
          await _placeService.getSuggestions(_searchController.text);
      setState(() {
        _suggestions = suggestions;
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  Future<void> _searchAndNavigate(String placeId) async {
    try {
      final location = await _placeService.getPlaceDetails(placeId);
      final LatLng searchedPosition = LatLng(location['lat'], location['lng']);

      _controller.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: searchedPosition, zoom: 14.0),
          ),
        );

        setState(() {
          _markers.add(
            Marker(
              markerId: const MarkerId('search_position'),
              position: searchedPosition,
              infoWindow: const InfoWindow(title: 'Position recherchée'),
            ),
          );
          _searchController.clear();
        });
      });
    } catch (e) {
      _showError('Erreur lors de la recherche de l\'adresse.');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    _customInfoWindowController.dispose();
    super.dispose();
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
                    _customInfoWindowController.googleMapController =
                        controller;
                    _controller.complete(controller);
                  },
                  onTap: (argument) {
                    _customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: _markers.toSet(),
                  circles: _circles.toSet(),
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  width: 250.w,
                  height: 230.h,
                  offset: 60,
                ),
                showTheme
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 70.w, bottom: 150.h),
                          child: Container(
                            width: 110.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: theme == ''
                                  ? const Color(0xFF1D1B31)
                                  : Colors.white,
                            ),
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
                                        fontSize: 14.sp),
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
                                        fontSize: 14.sp),
                                  ),
                                  onTap: () => setState(() {
                                    _controller.future.then((value) {
                                      DefaultAssetBundle.of(context)
                                          .loadString(
                                              'g_map_theme/night_theme.json')
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
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocus,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.w),
                              hintText: "Rechercher votre localisation",
                              suffixIcon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: (_searchController.text.isEmpty &&
                                    _suggestions.isEmpty)
                                ? false
                                : true,
                            child: Container(
                              margin: EdgeInsets.only(top: 20.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: Colors.white,
                              ),
                              height: 300.h,
                              child: ListView.separated(
                                itemCount: _suggestions.length,
                                itemBuilder: (context, index) {
                                  final suggestion = _suggestions[index];
                                  return ListTile(
                                    leading:
                                        const Icon(Icons.pin_drop_outlined),
                                    title: Text(suggestion['description']),
                                    onTap: () => _searchAndNavigate(
                                        suggestion['place_id']),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            )),
                      ]),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: _searchController.text.isEmpty ? true : false,
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
                                  onPressed: () async {
                                    await recenter();
                                    debugPrint('send_plane_line');
                                  },
                                  icon:
                                      const Icon(FlutterRemix.send_plane_line),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    _searchFocus.requestFocus();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      _controller.future.then((controller) {
                                        controller.animateCamera(
                                            CameraUpdate.zoomBy(1.0));
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
                                      debugPrint('minus $zoom');
                                      _controller.future.then((controller) {
                                        controller.animateCamera(
                                            CameraUpdate.zoomBy(-1.0));
                                      });
                                    },
                                    icon: const Icon(CupertinoIcons.minus),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
