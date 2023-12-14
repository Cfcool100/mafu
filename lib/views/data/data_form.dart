import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
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
  List<String> list = <String>['Elevé', 'Moyen', 'Faible'];
  String? dropdownValue;

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  String? base64String;

  Future<void> imageToBase64() async {
    final _pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (_pickedImage != null) {
      setState(() {
        _pickedFile = _pickedImage;
      });

      List<int> imageBytes = File(_pickedFile!.path).readAsBytesSync();
      base64String = base64Encode(imageBytes);
      print(base64String);
    } else {
      print('did not select an image');
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 316,
                // color: AppTheme.tertiaryColor,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: _kGooglePlex,
                    zoom: 15,
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
                  scrollGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                ),
              ),
              const Gap(20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputForm(
                      title: 'Localisation',
                      hint: 'Activer la position actuelle',
                      onChanged: (value) {
                        //
                      },
                      obscure: true,
                      type: TextInputType.text,
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputForm(
                          title: 'Date',
                          hint: 'Entrer la date',
                          onChanged: (value) {
                            //
                          },
                          width: 180,
                          type: TextInputType.text,
                        ),
                        InputForm(
                          title: 'Heure',
                          hint: 'Choisir l’heure',
                          onChanged: (value) {
                            //
                          },
                          width: 135,
                          type: TextInputType.text,
                        ),
                      ],
                    ),
                    Gap(20),
                    InputForm(
                      title: 'Description',
                      hint: 'Décrire l’inondation et le contexte approprié',
                      onChanged: (value) {
                        //
                      },
                      type: TextInputType.text,
                      height: 110,
                      maxLine: 5,
                    ),
                    Gap(20),
                    Text(
                      'Intensité de l’inondation',
                      style: AppTheme.textSemiBoldH5,
                    ),
                    Gap(10),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButton(
                        hint: const Text('Evaluer l’intensité de l’inondation'),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        value: dropdownValue,
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        underline: SizedBox(),
                        style: GoogleFonts.montserrat(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        icon: Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.grey,
                        ),
                        elevation: 2,
                        items: list.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text('$value'),
                          );
                        }).toList(),
                      ),
                    ),
                    Gap(20),
                    Text(
                      'Image',
                      style: AppTheme.textSemiBoldH5,
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            imageToBase64();
                          },
                          child: Container(
                            width: 114,
                            height: 115,
                            decoration: ShapeDecoration(
                              color: Color(0xFF111D4A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Icon(
                              CupertinoIcons.camera,
                              color: CupertinoColors.white,
                              size: 50.0,
                            ),
                          ),
                        ),
                        Container(
                          width: 236,
                          height: 115,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: _pickedFile != null
                                  ? FileImage(File(_pickedFile!.path))
                                      as ImageProvider<Object>
                                  : NetworkImage(
                                      "https://s3-alpha-sig.figma.com/img/77c2/17ff/a13bdf834705c44aa9d1b227365086f4?Expires=1703462400&Signature=ilkN~4vfHguKnwyl15EQANw24kyr8g88cxaNNm9ZsweVttSSQist8bT66QyglZXplqyI-sdOGFzakYD2juM6gkfPhtZ5W5oaNDi9dIiyhLUg6TsmkULFSuJCQ~GzU2IUUwcb2J8JM4s9MXh7O5Kd5~8WeXBai19JVe~Nq3RYYZz7g8h0odUCbB0B~AJcSYXUJj3TIp5dmmzLr~DXMhaRRl7tiUdH5oydlgLb5TgmQakNM~LjNhwHWXM40HbcSYSLTOV8aaw4E5cMY93NTNusWoe2D0ySfaz72m~-rD7gXUphbCz6wGBMoo1FqSqpyCM6Z2W16mXA8XmbrMrMLqpyVQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                    Gap(50),
                    PrimaryButton(
                      color: AppTheme.primaryColor,
                      textColor: CupertinoColors.white,
                      onPressed: () {
                        //
                      },
                      title: 'Envoyer l’alerte',
                    ),
                    Gap(30),
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

// api_key: AIzaSyAxtdCodXhHS0rd8MbX61O28jKuDlLRFUY
