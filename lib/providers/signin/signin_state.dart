part of 'signin_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    required this.email,
    required this.password,
    required this.isValid,
    required this.status,
  });

  final Email email;
  final PasswordValidator password;
  final FormzSubmissionStatus status; //
  final bool isValid;

  @override
  List<Object> get props => [email, password, isValid, status];

  SignInState copyWith(
      {Email? newEmail,
      PasswordValidator? newPassword,
      bool? newIsValid,
      FormzSubmissionStatus? newStatus}) {
    return SignInState(
      email: newEmail ?? email,
      password: newPassword ?? password,
      isValid: newIsValid ?? isValid,
      status: newStatus ?? status,
    );
  }
}
