part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.isValid,
    required this.status,
  });

  final Name firstname, lastname;
  final Email email;
  final PhoneNumber phoneNumber;
  final PasswordValidator password, confirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;

  @override
  List<Object> get props => [
        firstname,
        lastname,
        phoneNumber,
        password,
        confirmPassword,
        isValid,
        status
      ];

  SignupState copyWith({
    PhoneNumber? newPhoneNumber,
    Name? newFirstname,
    Name? newLastname,
    Email? newEmail,  
    PasswordValidator? newPassword,
    PasswordValidator? newConfirmPassword,
    bool? newIsValid,
    FormzSubmissionStatus? newStatus,
  }) {
    return SignupState(
      firstname: newFirstname ?? firstname,
      lastname: newLastname ?? lastname,
      email: newEmail ?? email,
      phoneNumber: newPhoneNumber ?? phoneNumber,
      password: newPassword ?? password,
      confirmPassword: newPassword ?? password,
      isValid: newIsValid ?? isValid,
      status: newStatus ?? status,
    );
  }
}
