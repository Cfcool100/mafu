// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends ChangeNotifier {
  static Future<bool> userRegister({
    required String email,
    required String lastname,
    required String firstname,
    required String number,
    required String password,
    required String confirmPassword,
    BuildContext? context,
  }) async {
    final body = {
      "userEmail": email.trim(),
      "userFirstName": firstname.trim(),
      "userLastName": lastname.trim(),
      "userNumber": number.trim(),
      "userPassword": password.trim(),
      "userPasswordC": confirmPassword.trim(),
    };

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.post(
        Uri.parse('https://mafu-back.vercel.app/users/signup'),
        headers: headers,
        body: json.encode(body),
      );

      debugPrint('Response body: ${response.body}');

      final data = json.decode(response.body);
      if (response.statusCode == 201 &&
          data['message'] == "User enregistré !") {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        final userData = data['data'];

        pref.setString('userData', jsonEncode(userData));

        debugPrint(pref.getString('userData'));

        return true;
        // PopUp(
        //   message: 'Inscription réussie. \nAllez à la page daccueil',
        // ).successAuth(context);
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('::::$e');
      return false;
    }
  }

  static Future<bool> userLogin(
      {required String email,
      required String password,
      BuildContext? context}) async {
    final body = {
      "userEmail": email.trim(),
      "userPassword": password.trim(),
    };
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    try {
      var url = Uri.parse('https://mafu-back.vercel.app/users/signin');
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      debugPrint('Response body: ${response.body}');

      final data = json.decode(response.body);
      if (response.statusCode == 201 && data['message'] == "connected") {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        final userData = data['data'];

        pref.setString('userData', jsonEncode(userData));

        debugPrint( 'data cached : \n${pref.getString('userData')}');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('::::$e');
      return false;
    }
  }
}
