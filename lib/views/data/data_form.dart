import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import 'package:mafuriko/controllers/alert.controller.dart';
import 'package:mafuriko/utils/pop_up.dart';
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
    getLocate();
  }

  Location location = Location();
  bool isLoad = false;

  List<String> list = <String>['Elevé', 'Moyen', 'Faible'];

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  String? base64String;

  Future<void> imageToBase64(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);

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

  @override
  void dispose() {
    super.dispose();

    _controller.isCompleted;
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _current = const LatLng(0, 9.450152);

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
            _current =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);

            debugPrint(':::::::::::::::::::::::::$currentLocation');
          }
        });
      }
    });
  }

  void showCustomBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150.h,
          decoration: BoxDecoration(
              color: Colors.white60,
              border: const Border(top: BorderSide(width: .3)),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r))),
          child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Gap(8.h),
              Text(
                'Choisissez comment envoyer l\'image :',
                style: GoogleFonts.montserrat(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              ListTile(
                leading: const Icon(FlutterRemix.gallery_line),
                title: Text(
                  'Galérie',
                  style: GoogleFonts.montserrat(fontSize: 15.sp),
                ),
                onTap: () {
                  imageToBase64(ImageSource.gallery);
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.camera),
                title: Text(
                  'Caméra',
                  style: GoogleFonts.montserrat(
                    fontSize: 15.sp,
                  ),
                ),
                onTap: () {
                  imageToBase64(ImageSource.camera);
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /*
A AJOUTER AU DESSUS DE EXPORT const upload = multer({ storage: storage });

  var limits = {
files: 1, // allow only 1 file per request
fileSize: 10 * 1024 * 1024, // 1 MB (max file size)
};
   */

  String description = '';
  String? dropdownValue;
  List<String> images = [
    'base64String',
  ];

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String formatHour(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

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
                height: 316.h,
                child: Stack(
                  children: [
                    GoogleMap(
                      key: ValueKey(isLoad),
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: isLoad
                            ? const LatLng(0.393037, 9.450152)
                            : _current,
                        zoom: 18,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                    if (isLoad)
                      Center(
                        child: SpinKitCubeGrid(
                          color: Colors.blueAccent.shade100,
                          size: 25.h,
                        ),
                      )
                  ],
                ),
              ),
              Gap(20.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const InputForm(
                      title: 'Lieu',
                      hint: 'Entrer le lieu de l\'alerte',
                      obscure: true,
                      type: TextInputType.text,
                    ),
                    Gap(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputForm(
                          controller: TextEditingController(
                              text: formatDate(DateTime.now())),
                          title: 'Date ${_current.longitude}',
                          enable: false,
                          width: 180.w,
                          type: TextInputType.text,
                        ),
                        InputForm(
                          title: 'Heure',
                          enable: false,
                          controller: TextEditingController(
                              text: formatHour(DateTime.now())),
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
                            // imageToBase64();
                            showCustomBottomSheet(context);
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
                            image: _pickedFile!);
                        PopUp.sendAlertSuccess(context,
                            message: '''Données chargées avec succès.
Revenir à la page de données''');
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
