import 'package:mongo_dart/mongo_dart.dart';

class UserModel {
  final ObjectId? id;
  final String? firstName;
  final String? lastName;
  final String userNumber;
  final String? userPassword;
  final String? parentalCode;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    required this.userNumber,
    this.userPassword,
    this.parentalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'userFirstName': firstName,
      'userLastName': lastName,
      'userNumber': userNumber,
      'codeSecurite': userPassword,
      'codeParental': parentalCode
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json, ObjectId id) {
    return UserModel(
      id: id,
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      userNumber: json['userNumber'],
      userPassword: json['codeSecurite'],
      parentalCode: json['codeParental'],
    );
  }
}
