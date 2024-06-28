import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:mafuriko/controllers/auth.controller.dart';
import 'package:mafuriko/validators/validators.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState.initial()) {
    on<SignInEmailChangedEvent>(_signInEmailChanged);
    on<SignInPasswordChangedEvent>(_signInPasswordChangedEvent);
    on<SubmitEvent>(_submitEvent);
    on<StopEvent>(_stopEvent);
    on<CurrentPasswordChangedEvent>(_currentPasswordChangedEvent);
    on<NewPasswordChangedEvent>(_newPasswordChangedEvent);
    on<NewPasswordConfirmationChangedEvent>(_newPasswordCChangedEvent);
    on<NewPasswordSubmitEvent>(_newPasswordSubmitEvent);
  }

  FutureOr<void> _signInEmailChanged(
      SignInEmailChangedEvent event, Emitter<SignInState> emit) {
    final mail = Email.dirty(event.email.trim());

    debugPrint('Login email from event: ${event.email}');

    debugPrint('::::::::::::::::::: login email:  ${mail.value} $mail');

    emit(
      state.copyWith(
        isValid: Formz.validate([mail, state.password]),
        email: mail,
      ),
    );
    debugPrint(
        '::::::::::::::::::: state login email:  ${state.email.value} ${state.email}');
  }

  FutureOr<void> _signInPasswordChangedEvent(
      SignInPasswordChangedEvent event, Emitter<SignInState> emit) {
    final pass = PasswordValidator.dirty(event.password);

    debugPrint('Login password from event: ${event.password}');

    debugPrint('::::::::::::::::::: login password:  ${pass.value} $pass');

    emit(
      state.copyWith(
        isValid: Formz.validate([state.email, pass]),
        password: pass,
      ),
    );
    debugPrint(
        '::::::::::::::::::: state login password:  ${state.password.value} ${state.password}');
  }

  FutureOr<void> _submitEvent(
      SubmitEvent event, Emitter<SignInState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        bool success = await Authentication.userLogin(
            email: state.email.value, password: state.password.value);
        if (success) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
          ));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.canceled));
      }
    }
  }

  FutureOr<void> _stopEvent(StopEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  FutureOr<void> _currentPasswordChangedEvent(
      CurrentPasswordChangedEvent event, Emitter<SignInState> emit) {
    final currentPassword = PasswordValidator.dirty(event.password);
    debugPrint('Current password from event: ${event.password}');

    debugPrint(
        '::::::::::::::::::: current password:  ${currentPassword.value} $currentPassword');
    emit(
      state.copyWith(
        currentPassword: currentPassword,
        isValid: Formz.validate(
            [currentPassword, state.newPassword, state.newConfirmPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    debugPrint(
        '::::::::::::::::::: state current password:  ${state.currentPassword.value} ${state.currentPassword}');
  }

  FutureOr<void> _newPasswordChangedEvent(
      NewPasswordChangedEvent event, Emitter<SignInState> emit) {
    final newPassword = PasswordValidator.dirty(event.password);
    debugPrint('New password from event: ${event.password}');

    debugPrint(
        '::::::::::::::::::: new password:  ${newPassword.value} $newPassword');
    emit(
      state.copyWith(
        newPassword: newPassword,
        isValid: Formz.validate(
            [state.currentPassword, newPassword, state.newConfirmPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    debugPrint(
        '::::::::::::::::::: state new password:  ${state.newPassword.value} ${state.newPassword}');
  }

  FutureOr<void> _newPasswordCChangedEvent(
      NewPasswordConfirmationChangedEvent event, Emitter<SignInState> emit) {
    final newConfirmPassword = PasswordValidator.dirty(event.password);
    debugPrint('Confirmation password from event: ${event.password}');

    debugPrint(
        '::::::::::::::::::: confirmation password:  ${newConfirmPassword.value} $newConfirmPassword');
    emit(
      state.copyWith(
        newConfirmPassword: newConfirmPassword,
        isValid: Formz.validate(
            [state.currentPassword, state.newPassword, newConfirmPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    debugPrint(
        '::::::::::::::::::: state confirmation password:  ${state.newConfirmPassword.value} ${state.newConfirmPassword}');
  }

  FutureOr<void> _newPasswordSubmitEvent(
      NewPasswordSubmitEvent event, Emitter<SignInState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        bool success = await Authentication.updateUserPassword(
            currentPassword: state.currentPassword.value,
            newPassword: state.newPassword.value,
            passwordConfirmation: state.newConfirmPassword.value);
        if (success) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
          ));
        } else {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.canceled,
        ));
      }
    }
  }
}
