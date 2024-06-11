part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupFirstNameChangedEvent extends SignupEvent {
  const SignupFirstNameChangedEvent(this.firstname);

  final String firstname;
  @override
  List<Object> get props => [firstname];
}

class SignupLastNameChangedEvent extends SignupEvent {
  const SignupLastNameChangedEvent(this.lastname);

  final String lastname;
  @override
  List<Object> get props => [lastname];
}

class SignupEmailChangedEvent extends SignupEvent {
  const SignupEmailChangedEvent(this.email);

  final String email;
}

class SignupPhoneNumberChangedEvent extends SignupEvent {
  const SignupPhoneNumberChangedEvent(this.phoneNumber);

  final String phoneNumber;
}

class SignupPasswordChangedEvent extends SignupEvent {
  const SignupPasswordChangedEvent(this.password);

  final String password;
  @override
  List<Object> get props => [password];
}

class SignupConfirmPasswordChangedEvent extends SignupEvent {
  const SignupConfirmPasswordChangedEvent(this.confirmPassword);

  final String confirmPassword;
  @override
  List<Object> get props => [confirmPassword];
}

class SignupSubmitEvent extends SignupEvent {}
