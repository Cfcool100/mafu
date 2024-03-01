

class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String userNumber;
  final String userEmail;
  final String? userPassword;
  final String? parentalCode;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    required this.userEmail,
    required this.userNumber,
    this.userPassword,
    this.parentalCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'userFirstName': firstName,
      'userLastName': lastName,
      'userEmail': userEmail,
      'userNumber': userNumber,
      'codeSecurite': userPassword,
      'codeParental': parentalCode
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      userEmail: json['userEmail'],
      userNumber: json['userNumber'],
      userPassword: json['codeSecurite'],
      parentalCode: json['codeParental'],
    );
  }
}
