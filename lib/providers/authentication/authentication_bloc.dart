import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mafuriko/models/user.models.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);

    _tryGetUser().asStream().listen((user) {
      if (user != null) {
        add(AuthenticationStatusChanged(AuthenticationStatus.authenticated));
        print('success authentication ${user.firstName} !');
      } else {
        add(AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
        print('failed authentication!');
      }
    });
  }

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onAuthenticationStatusChanged(
      AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  FutureOr<void> _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    add(AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
    pref.clear();
  }

  Future<UserModel?> _tryGetUser() async {
    try {
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      var userData = _pref.getString('userData');
      if (userData != null ) {
        var decodedData = jsonDecode(userData);
        final user = UserModel.fromJson(decodedData);
        return user;
      } else {
        print('::::::::::::::::: Nothing cached :::::::::::::::::');
        return null;
      }
    } catch (e) {
      print(e);
      print(
          'Une erreur s\'est produite lors de la récupération des données utilisateur en cache: \n$e');
      return null;
    }
  }
}
