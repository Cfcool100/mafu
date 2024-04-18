// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/models/alert.models.dart';
// import 'package:location/location.dart';
// import 'package:mafuriko/utils/pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Alert extends ChangeNotifier {
  static Future<void> sendAlert({
    required LatLng position,
    required String description,
    required String intensity,
    required XFile image,
  }) async {
    final dio = Dio();

    final FormData formData = FormData();

    try {
      formData.files.addAll([
        MapEntry("files", await MultipartFile.fromFile(File(image.path).path)),
      ]);

      formData.fields.add(MapEntry('longitude', position.longitude.toString()));
      formData.fields.add(MapEntry('latitude', position.latitude.toString()));
      formData.fields.add(MapEntry('floodDescription', description));
      formData.fields.add(MapEntry('floodIntensity', intensity));

      debugPrint('>>>>>>>>>>>>>>>>>>>>${formData.fields}>>>>>>>>>>>>>>>>>>>>');
      debugPrint(
          '========================${formData.files.first}========================');

      // final formData = FormData.fromMap({
      //   'longitude': '${position.longitude}',
      //   'latitude': '${position.latitude}',
      //   'floodDescription': description,
      //   'floodIntensity': intensity,
      //   // 'date': DateTime.now().toIso8601String(),
      //   // 'floodImages': await MultipartFile.fromFile(image.path,
      //   //     filename: 'image.jpg'),
      // });

      // formData.files.add(value)
      final response = await dio.post(
        'https://mafu-back.vercel.app/zonesInondees',
        data: formData,
      );

      debugPrint('Response body: ${response.data}');
    } catch (e) {
      debugPrint('????????????$e ????????????????');
    }
  }

  static Future<void> fetchAlert() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final response = await http.get(
          Uri.parse('https://mafu-back.vercel.app/zonesInondees'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });

      // debugPrint('Response body: ${response.body}');

      final List<dynamic> dataList = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Convertir la liste d'alertes d'inondation en une liste d'objets FloodAlert
        List<FloodAlert> alertList =
            dataList.map((item) => FloodAlert.fromJson(item)).toList();

        // Convertir la liste d'objets FloodAlert en une liste d'objets JSON
        List<Map<String, dynamic>> jsonList =
            alertList.map((alert) => alert.toJson()).toList();

        // Enregistrer la liste d'objets JSON dans SharedPreferences
        pref.setString('FloodAlert', jsonEncode(jsonList));

        // Afficher les données pour vérification
        // print('Stored Flood Alerts: $alertList');
        debugPrint(
            '>>>>>>>>>>>>>>>>>>\n*********************\n$alertList\n>>>>>>>>>>>>>>>>>>\n*********************');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
