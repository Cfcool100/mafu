// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
// import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/utils/interceptor_client_utils.dart';
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
    // final FormData formData = FormData();

    try {
      Uri? floodImageUri;
      if (image != null) {
        floodImageUri = await uploadFile(File(image.path), "alerts");
        debugPrint('flood image take by user  $floodImageUri');
      }

      // if (floodImageUri != null) {
      //   request["proprietyImages"] = floodImageUri.toString();
      // }

      final request = http.Request(
          'POST', Uri.parse('https://mafu-back.vercel.app/zones-inondees/add'));

      request.body = json.encode({
        'floodScene': location,
        "floodLocation": {
          'longitude': '${position.longitude}',
          'latitude': '${position.latitude}',
        },
        'floodDescription': description,
        'floodIntensity': intensity,
        'floodImage': '$floodImageUri'
      });

      debugPrint('>>>>>>>>>>>>>>>>>>>>${request.body}>>>>>>>>>>>>>>>>>>>>');

      // formData.files.add(value)
      final response = await ClientService.client.send(request);
      debugPrint(
          '========================${response.reasonPhrase}========================');

      final body = await response.stream.transform(utf8.decoder).join();

      if (response.statusCode == 201) {
        debugPrint('Response body: ${jsonDecode(body)}');
        return true;
      } else {
        debugPrint('Response Failed body: ${response.statusCode}');
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
      final response = await ClientService.client.get(
        Uri.parse('https://mafu-back.vercel.app/zones-inondees/all-infos'),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> dataList = jsonDecode(response.body)["data"];

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
