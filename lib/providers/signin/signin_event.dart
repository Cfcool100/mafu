part of 'signin_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInInitialEvent extends SignInEvent {}

class SignInEmailChangedEvent extends SignInEvent {
  const SignInEmailChangedEvent(this.email);

  final String email;
}

class SignInPasswordChangedEvent extends SignInEvent {
  const SignInPasswordChangedEvent(this.password);

  final String password;
}

class SubmitEvent extends SignInEvent {}
