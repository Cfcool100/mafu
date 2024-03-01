import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mafuriko/controllers/auth.controller.dart';
import 'package:mafuriko/validators/validators.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc()
      : super(const SignInState(
          isValid: false,
          password: PasswordValidator.pure(),
          email: Email.pure(),
          status: FormzSubmissionStatus.initial,
        )) {
    on<SignInEmailChangedEvent>(_signInEmailrChanged);
    on<SignInPasswordChangedEvent>(_signInPasswordChangedEvent);
    on<SubmitEvent>(_submitEvent);
  }

  FutureOr<void> _signInEmailrChanged(SignInEmailChangedEvent event, Emitter<SignInState> emit) {

    final mail = Email.dirty(event.email);

    emit(
      state.copyWith(
          newIsValid: Formz.validate([mail, state.password]),
          newEmail: mail,
          newPassword: PasswordValidator.dirty(state.password.value),
          newStatus: FormzSubmissionStatus.initial),
    );

  }

  FutureOr<void> _signInPasswordChangedEvent(SignInPasswordChangedEvent event, Emitter<SignInState> emit) {

    final pass = PasswordValidator.dirty(event.password);

    emit(
      state.copyWith(
          newIsValid: Formz.validate([state.email, pass]),
          newEmail: Email.dirty(state.email.value),
          newPassword: pass,
          newStatus: FormzSubmissionStatus.initial),
    );
  }

  FutureOr<void> _submitEvent(SubmitEvent event, Emitter<SignInState> emit) async{

    if (state.isValid) {
      emit(state.copyWith(newStatus: FormzSubmissionStatus.inProgress));

      try {
        bool success = await Authentication.userLogin(
            email: state.email.value,
            password: state.password.value);
        if (success) {
          emit(state.copyWith(
            newStatus: FormzSubmissionStatus.success,
          ));
        } else {
          emit(state.copyWith(newStatus: FormzSubmissionStatus.failure));
        }
      } catch (e) {
        emit(state.copyWith(newStatus: FormzSubmissionStatus.failure));
      }
    }
    
  }
}
