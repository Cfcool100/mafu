// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/utils/upload_to_digit_oc.dart';
// import 'package:location/location.dart';
// import 'package:mafuriko/utils/pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Alert extends ChangeNotifier {
  static Future<bool> sendAlert({
    required LatLng position,
    required String location,
    required String description,
    required String intensity,
    XFile? image,
  }) async {
    final dio = Dio();

    // final FormData formData = FormData();

    try {
      // formData.files.addAll([
      //   MapEntry(
      //       "files",
      //       await MultipartFile.fromFile(File(
      //               '/data/user/0/com.geodaftar.mafuriko/cache/86fc05f6-5f1a-42af-8e26-1213275e7443/1000000042.jpg')
      //           .path)),
      // ]);

      // formData.fields.add(MapEntry('longitude', position.longitude.toString()));
      // formData.fields.add(MapEntry('latitude', position.latitude.toString()));
      // formData.fields.add(MapEntry('floodDescription', description));
      // formData.fields.add(MapEntry('floodIntensity', intensity));
      Uri? floodImageUri;
      if (image != null) {
        floodImageUri = await uploadFile(File(image.path), "alerts");
        debugPrint('flood image take by user  $floodImageUri');
      }

      final Map<String, dynamic> formData = {
        'floodScene': location,
        'longitude': '${position.longitude}',
        'latitude': '${position.latitude}',
        'floodDescription': description,
        'floodIntensity': intensity,
      };

      if (floodImageUri != null) {
        formData["proprietyImages"] = floodImageUri.toString();
      }

      debugPrint('>>>>>>>>>>>>>>>>>>>>${formData.entries}>>>>>>>>>>>>>>>>>>>>');
      debugPrint(
          '========================${formData.values.first}========================');

      // formData.files.add(value)
      final response = await dio.post(
        'https://mafu-back.vercel.app/zonesInondees',
        data: formData,
      );

      if (response.statusCode == 200) {
        debugPrint('Response body: ${response.data}');
        return true;
      } else {
        debugPrint('Response Failed body: ${response.data}');
        return false;
      }
    } catch (e) {
      debugPrint(
          '::::::::::::::::::::::::\n::::::::::::::::::$e ::::::::::::::::::::::::\n::::::::::::::::::');
      return false;
    }
  }

  static Future<List<FloodAlert>> fetchAlert() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final response = await http.get(
        Uri.parse('https://mafu-back.vercel.app/zonesInondees'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = jsonDecode(response.body);

        // Vérifiez si dataList est une liste et contient des éléments
        if (dataList.isNotEmpty) {
          // Convertir la liste d'alertes d'inondation en une liste d'objets FloodAlert
          List<FloodAlert> alertList =
              dataList.map((item) => FloodAlert.fromJson(item)).toList();

          // Convertir la liste d'objets FloodAlert en une liste d'objets JSON
          List<Map<String, dynamic>> jsonList =
              alertList.map((alert) => alert.toJson()).toList();

          // Enregistrer la liste d'objets JSON dans SharedPreferences
          await pref.setString('FloodAlert', jsonEncode(jsonList));

          debugPrint('Stored Flood Alerts: $alertList');
          return alertList;
        } else {
          debugPrint('Data list is empty or not a list');
          return [];
        }
      } else {
        debugPrint(
            'Failed to load alerts. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching alerts: ${e.toString()}');
      return [];
    }
  }
}
