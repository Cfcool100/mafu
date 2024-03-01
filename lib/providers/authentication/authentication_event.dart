part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

sealed class AuthenticationEvent extends Equatable {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
  
  @override

  List<Object?> get props => [status];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {
  @override

  List<Object?> get props => [];
}