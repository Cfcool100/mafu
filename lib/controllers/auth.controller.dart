// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/utils/interceptor_client_utils.dart';
import 'package:mafuriko/utils/upload_to_digit_oc.dart';

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
          data['message'] == "User registered !") {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        final userData = data['data'];
        final token = data['token'];

        pref.setString('userData', jsonEncode(userData));
        pref.setString('token', token);

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
      if (response.statusCode == 201 && data['message'] == "User conneted!") {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        final userData = data['data'];
        final token = data['token'];

        pref.setString('userData', jsonEncode(userData));
        pref.setString('token', token);

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
    try {
      final uri =
          Uri.parse('https://mafu-back.vercel.app/users/update-password');
      final request = http.Request('PUT', uri);

      request.body = json.encode({
        "userPassword": currentPassword,
        "usernewPassword": newPassword,
        "usernewPasswordC": passwordConfirmation,
      });

      final response = await ClientService.client.send(request);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('####################### $e');
      return false;
    }
  }

  static Future<bool> updateUser(
      {required String lastName,
      required String firstName,
      XFile? image,
      required String phoneNumber}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      Uri? userImageUri;
      if (image != null) {
        userImageUri = await uploadFile(File(image.path), "user");
        debugPrint('avatar image take by user  ${userImageUri?.toString()}');
      }
      final uri = Uri.parse('https://mafu-back.vercel.app/users/update');
      final request = http.Request('PUT', uri);

      // request.fields['userLastName'] = lastName;
      // request.fields['userFirstName'] = firstName;
      // request.fields['userNumber'] = phoneNumber;

      if (userImageUri != null) {
        request.body = json.encode({
          "image": userImageUri.toString(),
          "userFirstName": firstName,
          "userLastName": lastName,
          "userNumber": phoneNumber
        });
      } else {
        request.body = json.encode({
          "userFirstName": firstName,
          "userLastName": lastName,
          "userNumber": phoneNumber
        });
      }

      final response = await ClientService.client.send(request);

      final myData = await response.stream.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        var updatedData = jsonDecode(myData)['data'];
        debugPrint('data updated:::::::::::: $updatedData');
        await pref.remove("userData");
        pref.setString('userData', jsonEncode(updatedData));

        return true;
      }
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
