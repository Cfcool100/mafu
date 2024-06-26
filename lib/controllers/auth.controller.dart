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

        debugPrint('data cached : \n${pref.getString('userData')}');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('::::$e');
      return false;
    }
  }

  static Future<bool> updateUserPassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  }) async {
    final body = {
      "userPassword": "12345",
      "usernewPassword": "13579",
      "usernewPasswordC": "13579"
    };

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'token'
    };
    try {
      final response = await http.put(
        Uri.parse('https://mafu-back.vercel.app/users/signup'),
        headers: headers,
        body: json.encode(body),
      );
      if (response.statusCode == 200) true;
      return false;
    } catch (e) {
      debugPrint('####################### $e');
      return false;
    }
  }

  static Future<bool> updateUser(
      {required String lastName,
      required String firstName,
      required String phoneNumber}) async {
    final body = {
      "image":
          "https://www.figma.com/design/YhOJi4lKOkFNkbAwamSjHY/Mafuriko-Design?node-id=70-4065",
      "userFirstName": firstName
    };

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'token'
    };
    try {
      final response = await http.put(
        Uri.parse('https://mafu-back.vercel.app/users/signup'),
        headers: headers,
        body: json.encode(body),
      );
      if (response.statusCode == 200) true;
      return false;
    } catch (e) {
      debugPrint('####################### $e');
      return false;
    }
  }

//  ===> update user

// Header = {“Authorization” : “Token”}

// Body = {
  // "image" : "https://www.figma.com/design/YhOJi4lKOkFNkbAwamSjHY/Mafuriko-Design?node-id=70-4065",
  // "userFirstName": "Kone"
// }

//  ===> update user password

// Header = {“Authorization” : “Token”}

// Body = {
  // "userPassword": "12345",
  // "usernewPassword": "13579",
  // "usernewPasswordC": "13579"
// }
}
