import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mafuriko/utils/pop_up.dart';

class Alert extends ChangeNotifier {
  void sendAlert({
    required Map<String, String> position,
    required String date,
    required String description,
    required String intensity,
    required String image,
    BuildContext? context,
  }) async {
    notifyListeners();

    final body = {
      "floodLocation": position,
      "floodDate": date,
      "floodDescription": description.trim(),
      "floodIntensity": intensity.trim(),
      "floodImage": [image.trim()],
    };

    try {
      final response = await http.post(
        Uri.parse('https://mafu-back.vercel.app/zonesInondees'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      debugPrint('Response body: ${response.body}');

      final resDec = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // final id = resDec['data']['_id'];
        // final email = resDec['data']['userEmail'];
        // final firstname = resDec['data']['userFirstName'];
        // final lastname = resDec['data']['userLastName'];
        // final number = resDec['data']['userNumber'];
        // final password = resDec['data']['userPassword'];

        // DatabaseProvider().saveId(id);
        // DatabaseProvider().saveEmail(email);
        // DatabaseProvider().saveNumber(number);
        // DatabaseProvider().saveFirstName(firstname);
        // DatabaseProvider().saveLastName(lastname);
        // DatabaseProvider().savePassword(password);

        if (context != null && resDec["message"] == "Objet enregistré") {
          // Add null check for context

          // // ignore: use_build_context_synchronously

          PopUp(message: '''  Données chargées avec succès.
Revenir à la page de données''').successAuth(context);
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => const HomePage(),
          // ));
        }
      }
    } catch (e) {
      print('::::$e');
    }
  }
}
