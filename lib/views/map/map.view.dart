import 'dart:async';
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
    // TODO: implement initState
    super.initState();
    getLocate();
  }

  Location location = Location();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng _kGooglePlex = LatLng(5.363037, -4.027152);
  static const LatLng _kApplePark = LatLng(5.372475, -4.020844);

  late LatLng _currentPosition;

  Future<void> getLocate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((currentLocation) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          if (currentLocation.latitude != null &&
              currentLocation.longitude != null) {
            _currentPosition =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: _kGooglePlex,
          zoom: 13,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          const Marker(
            markerId: MarkerId('_currentPosition'),
            position: _kGooglePlex,
            icon: BitmapDescriptor.defaultMarker,
          ),
        },
      ),
    );
  }
}
