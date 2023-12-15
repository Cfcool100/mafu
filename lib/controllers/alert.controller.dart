import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/utils/pop_up.dart';

class Alert extends ChangeNotifier {
  void sendAlert({
    required Map<String, String> position,
    required String description,
    required String intensity,
    required String image,
    BuildContext? context,
  }) async {
    notifyListeners();

    final floodAlert = FloodAlert(
      floodLocation: position,
      floodDate: DateTime.now().toUtc(),
      floodDescription: description,
      floodIntensity: intensity,
      floodImages: [
        image,
      ],
    );

    final body = floodAlert.toMap();

    try {
      final response = await http.post(
        Uri.parse('https://mafu-back.vercel.app/zonesInondees'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body),
      );

      debugPrint('Response body: ${response.statusCode}');

      final resDec = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (context != null && resDec["message"] == "Objet enregistré") {
          // ignore: use_build_context_synchronously
          PopUp(message: '''  Données chargées avec succès.
Revenir à la page de données''').successAuth(context);
        }
      }
    } catch (e) {
      debugPrint('::::$e');
    }
  }
}
