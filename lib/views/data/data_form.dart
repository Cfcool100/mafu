import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/controllers/alert.controller.dart';
import 'package:mafuriko/utils/themes.dart';
import 'package:mafuriko/widgets/button.dart';
import 'package:mafuriko/widgets/form.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});
  static String id = 'data/form';

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  @override
  void initState() {
    super.initState();
    _getLocate();
  }

  List<String> list = <String>['Elevé', 'Moyen', 'Faible'];

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  String? base64String;

  Future<void> imageToBase64() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _pickedFile = pickedImage;
      });

      List<int> imageBytes = File(_pickedFile!.path).readAsBytesSync();

      img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

      int quality = 80;

      // Encodez l'image compressée en JPEG
      List<int> compressedBytes = img.encodeJpg(image, quality: quality);

      base64String = base64Encode(compressedBytes);

      // Afficher la taille originale et la taille compressée
      debugPrint('Taille originale: ${imageBytes.length} bytes');
      debugPrint('Taille compressée: ${compressedBytes.length} bytes');
      debugPrint(base64String);
    } else {
      debugPrint('did not select an image');
    }
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _current = const LatLng(9.103, 5.51);

  Future<Position> _getLocate() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _current = const LatLng(-3.921089, 5.318270);
    });

    return position;
  }

  // final position = {
  //   'lat': '${_current.latitude}',
  //   'lon': '${_current.longitude}',
  // };
  final date =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  final hour =
      '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, "0")}';
  String description = '';
  String? dropdownValue;
  List<String> images = [
    'base64String',
  ];

  @override
  Widget build(BuildContext context) {
    // debugPrint('$position');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 316.w,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _current,
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  // zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                ),
              ),
              Gap(20.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const InputForm(
                      title: 'Localisation',
                      hint: 'Position actuelle',
                      enable: false,
                      obscure: true,
                      type: TextInputType.text,
                    ),
                    Gap(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputForm(
                          controller: TextEditingController(text: date),
                          title: 'Date',
                          enable: false,
                          width: 180.w,
                          type: TextInputType.text,
                        ),
                        InputForm(
                          title: 'Heure',
                          enable: false,
                          controller: TextEditingController(text: hour),
                          width: 135.w,
                          type: TextInputType.text,
                        ),
                      ],
                    ),
                    Gap(20.h),
                    InputForm(
                      title: 'Description',
                      hint: 'Décrire l’inondation et le contexte approprié',
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      type: TextInputType.text,
                      height: 110.h,
                      maxLine: 5,
                    ),
                    Gap(20.h),
                    Text(
                      'Intensité de l’inondation',
                      style: AppTheme.textSemiBoldH5,
                    ),
                    Gap(10.h),
                    Container(
                      height: 40.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.w),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButton(
                        hint: const Text('Evaluer l’intensité de l’inondation'),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        value: dropdownValue,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                        icon: const Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.grey,
                        ),
                        elevation: 2,
                        items: list.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Gap(20.h),
                    Text(
                      'Image',
                      style: AppTheme.textSemiBoldH5,
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            imageToBase64();
                          },
                          child: Container(
                            width: 114.w,
                            height: 115.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF111D4A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                            child: Icon(
                              CupertinoIcons.camera,
                              color: CupertinoColors.white,
                              size: 50.dm,
                            ),
                          ),
                        ),
                        Container(
                          width: 236.w,
                          height: 115.h,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: _pickedFile != null
                                  ? FileImage(File(_pickedFile!.path))
                                      as ImageProvider<Object>
                                  : const AssetImage("images/image.png"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                        ),
                      ],
                    ),
                    Gap(50.h),
                    PrimaryButton(
                      color: AppTheme.primaryColor,
                      textColor: CupertinoColors.white,
                      onPressed: () {
                        Alert.sendAlert(
                          position: _current,
                          description: description,
                          intensity: dropdownValue ?? 'null',
                        );
                      },
                      title: 'Envoyer l’alerte',
                    ),
                    Gap(30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
