import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _firstname = '';
  String get firstname => _firstname;

  void saveFirstName(String firstname) async {
    SharedPreferences value = await _pref;
    value.setString('userFirstName', firstname);
    _firstname = firstname;
    notifyListeners();
    print('Saved firstname: $_firstname');
  }

  String _lastname = '';
  String get lastname => _lastname;

  void saveLastName(String lastname) async {
    SharedPreferences value = await _pref;
    value.setString('userLastName', lastname);
    _firstname = lastname;
    notifyListeners();
    print('Saved lastname: $_firstname');
  }

  String _id = '';

  String get id => _id;

  void saveId(String id) async {
    print('Saving ID: $id');
    SharedPreferences value = await _pref;
    value.setString('_id', id);
    _id = id;
    notifyListeners();
    print('Saved ID: $_id');
  }

  String _email = '';

  String get email => _email;

  void saveEmail(String email) async {
    SharedPreferences value = await _pref;
    value.setString('userEmail', email);
    _email = email;
    notifyListeners();
    print('Saved Email: $_email');
  }

  String _number = '';

  String get number => _number;

  void saveNumber(String number) async {
    SharedPreferences value = await _pref;
    value.setString('userNumber', number);
    _number = number;
    notifyListeners();
  }

  String _password = '';

  String get password => _password;

  void savePassword(String password) async {
    SharedPreferences value = await _pref;
    value.setString('userPassword', password);
    _password = password;
    notifyListeners();
  }

  Future<Map<String, String>> getUser() async {
    SharedPreferences value = await _pref;
    String id = value.getString('_id') ?? '';
    String email = value.getString('userEmail') ?? '';
    String number = value.getString('userNumber') ?? '';
    String firstname = value.getString('userFirstName') ?? '';
    String lastname = value.getString('userLastName') ?? '';
    String password = value.getString('userPassword') ?? '';

    _id = id;
    _email = email;
    _firstname = firstname;
    _lastname = lastname;
    _number = number;
    _password = password;

    notifyListeners();

    return {'name': firstname, 'id': id, 'number': number};
  }
}
