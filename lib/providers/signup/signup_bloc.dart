import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:mafuriko/controllers/controller.dart';
import 'package:mafuriko/validators/validators.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc()
      : super(
          const SignupState(
            isValid: false,
            firstname: Name.pure(),
            lastname: Name.pure(),
            email: Email.pure(),
            confirmPassword: PasswordValidator.pure(),
            password: PasswordValidator.pure(),
            phoneNumber: PhoneNumber.pure(),
            status: FormzSubmissionStatus.initial,
          ),
        ) {
    on<SignupFirstNameChangedEvent>(_signupFirstNameChangedEvent);
    on<SignupLastNameChangedEvent>(_signupLastNameChangedEvent);

    on<SignupEmailChangedEvent>(_signupEmailChangedEvent);
    on<SignupPhoneNumberChangedEvent>(_signupPhoneNumberChangedEvent);

    on<SignupPasswordChangedEvent>(_signupPasswordChangedEvent);
    on<SignupConfirmPasswordChangedEvent>(_signupConfirmPasswordChangedEvent);

    on<SignupSubmitEvent>(_signupSubmitEvent);
  }
  FutureOr<void> _signupFirstNameChangedEvent(
      SignupFirstNameChangedEvent event, Emitter<SignupState> emit) {
    final firstname = Name.dirty(event.firstname.isNotEmpty
        ? event.firstname[0].toUpperCase() + event.firstname.substring(1).trim()
        : event.firstname);

    debugPrint('signup firstname: $firstname');

    emit(state.copyWith(
        newFirstname: firstname,
        newIsValid: Formz.validate([
          firstname,
          state.lastname,
          state.phoneNumber,
          state.email,
          state.password,
          state.confirmPassword
        ]),
        newStatus: FormzSubmissionStatus.initial));
  }

  FutureOr<void> _signupLastNameChangedEvent(
      SignupLastNameChangedEvent event, Emitter<SignupState> emit) {
    final lastname = Name.dirty(event.lastname.isNotEmpty
        ? event.lastname[0].toUpperCase() + event.lastname.substring(1).trim()
        : event.lastname);

    debugPrint('signup lastname: $lastname');

    emit(state.copyWith(
        newLastname: lastname,
        newIsValid: Formz.validate([
          state.firstname,
          lastname,
          state.phoneNumber,
          state.email,
          state.password,
          state.confirmPassword
        ]),
        newStatus: FormzSubmissionStatus.initial));
  }

  FutureOr<void> _signupEmailChangedEvent(
      SignupEmailChangedEvent event, Emitter<SignupState> emit) {
    final mail = Email.dirty(event.email.trim());

    debugPrint('signup mail: $mail');

    emit(state.copyWith(
        newEmail: mail,
        newIsValid: Formz.validate([
          state.firstname,
          state.lastname,
          state.phoneNumber,
          mail,
          state.password,
          state.confirmPassword
        ]),
        newStatus: FormzSubmissionStatus.initial));
  }

  FutureOr<void> _signupPhoneNumberChangedEvent(
      SignupPhoneNumberChangedEvent event, Emitter<SignupState> emit) {
    final phone = PhoneNumber.dirty(event.phoneNumber);

    debugPrint('signup phone: $phone');

    emit(state.copyWith(
        newIsValid: Formz.validate([
          state.firstname,
          state.lastname,
          phone,
          state.email,
          state.password,
          state.confirmPassword
        ]),
        newPhoneNumber: phone,
        newStatus: FormzSubmissionStatus.initial));
  }

  FutureOr<void> _signupPasswordChangedEvent(
      SignupPasswordChangedEvent event, Emitter<SignupState> emit) {
    final pass = PasswordValidator.dirty(event.password);

    debugPrint('signup password: $pass');
    emit(
      state.copyWith(
        newIsValid: Formz.validate([
          state.firstname,
          state.lastname,
          state.phoneNumber,
          state.email,
          pass,
          state.confirmPassword
        ]),
        newPassword: pass,
        newStatus: FormzSubmissionStatus.initial,
      ),
    );
  }

  FutureOr<void> _signupConfirmPasswordChangedEvent(
      SignupConfirmPasswordChangedEvent event, Emitter<SignupState> emit) {
    final confirmPass = PasswordValidator.dirty(event.confirmPassword);

    debugPrint('signup confirmPass: $confirmPass');

    emit(
      state.copyWith(
        newIsValid: Formz.validate([
          state.firstname,
          state.lastname,
          state.phoneNumber,
          state.email,
          state.password,
          confirmPass
        ]),
        newConfirmPassword: confirmPass,
        newStatus: FormzSubmissionStatus.initial,
      ),
    );
  }

  FutureOr<void> _signupSubmitEvent(
      SignupEvent event, Emitter<SignupState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(newStatus: FormzSubmissionStatus.inProgress));

      try {
        bool success = await Authentication.userRegister(
          firstname: state.firstname.value,
          lastname: state.lastname.value,
          email: state.email.value,
          number: state.phoneNumber.value,
          password: state.password.value,
          confirmPassword: state.confirmPassword.value,
        );
        if (success) {
          emit(state.copyWith(
            newStatus: FormzSubmissionStatus.success,
          ));
        } else {
          emit(state.copyWith(newStatus: FormzSubmissionStatus.failure));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(newStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
