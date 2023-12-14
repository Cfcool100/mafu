import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mafuriko/providers/user.providers.dart';
import 'package:mafuriko/views/home/home.view.dart';

class Authentication extends ChangeNotifier {
  void userRegister({
    required String email,
    required String lastname,
    required String firstname,
    required String number,
    required String password,
    BuildContext? context,
  }) async {
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://mafu-back.vercel.app/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response body: ${response.body}');

      final resDec = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final id = resDec['_id'];
        final email = resDec['userEmail'];
        final firstname = resDec['userFirstName'];
        final lastname = resDec['userLastName'];
        final number = resDec['userNumber'];
        final password = resDec['userPassword'];

        DatabaseProvider().saveId(id);
        DatabaseProvider().saveEmail(email);
        DatabaseProvider().saveNumber(number);
        DatabaseProvider().saveFirstName(firstname);
        DatabaseProvider().saveLastName(lastname);
        DatabaseProvider().savePassword(password);

        if (context != null && resDec['userEmail'] == email) {
          // Add null check for context

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        }
      }
    } catch (e) {
      print('::::$e');
    }
  }

  void userLogin({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    notifyListeners();

    final body = {
      "userEmail": email,
      "userPassword": password,
    };

    try {
      final response = await http.post(
        Uri.parse('https://mafu-back.vercel.app/users/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      debugPrint('Response body: ${response.body}');

      final resDec = json.decode(response.body);
      if (response.statusCode == 201) {
        final id = resDec['data']['_id'];
        final email = resDec['data']['userEmail'];
        final firstname = resDec['data']['userFirstName'];
        final lastname = resDec['data']['userLastName'];
        final number = resDec['data']['userNumber'];
        final password = resDec['data']['userPassword'];

        DatabaseProvider().saveId(id);
        DatabaseProvider().saveEmail(email);
        DatabaseProvider().saveNumber(number);
        DatabaseProvider().saveFirstName(firstname);
        DatabaseProvider().saveLastName(lastname);
        DatabaseProvider().savePassword(password);

        if (context != null && resDec['message'] == 'connected') {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        }
      }
    } catch (e) {
      print('::::$e');
    }
  }
}
