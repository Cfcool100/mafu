import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/controllers/auth.controller.dart';
import 'package:mafuriko/models/user.models.dart';
import 'package:mafuriko/utils/files_picker.dart';
import 'package:mafuriko/validators/name.validator.dart';
import 'package:mafuriko/validators/phone.validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FilesPicker getImages = FilesPicker();
  ProfileBloc() : super(ProfileState.initial()) {
    on<PickedImageFromGallery>(_pickedImageFromGallery);
    on<ProfileFirstNameChangedEvent>(_firstNameChangedEvent);
    on<ProfileLastNameChangedEvent>(_lastNameChangedEvent);
    on<ProfilePhoneNumberChangedEvent>(_phoneNumberChangedEvent);
    on<ProfileUserModelDataEvent>(_loadProfileUserModelDataEvent);
    on<ProfileUpdateEvent>(_onUpdateEvent);
    on<SubmitForm>(_submitForm);
    on<Initial>(_initialEvent);

    _tryGetUser2().asStream().listen((user) {
      log(':::::::::::===========_tryGetUser2 ${user?.toJson()}');
      if (user != null) {
        add(ProfileUserModelDataEvent(user));
        add(ProfileFirstNameChangedEvent(user.firstName!));
        add(ProfileLastNameChangedEvent(user.lastName!));
        add(ProfilePhoneNumberChangedEvent(user.userNumber!));
      }
    });
  }
  void _loadProfileUserModelDataEvent(
      ProfileUserModelDataEvent event, Emitter<ProfileState> emit) async {
    debugPrint(
        '_laodProfileUserModelDataEvent: >>>>>>>>>>>> ${event.user.toJson()}');
    //final user = await _tryGetUser2();
    emit(state.copyWith(user: event.user));
  }

  void _pickedImageFromGallery(
      PickedImageFromGallery event, Emitter<ProfileState> emit) async {
    /// store the image we get from the gallery
    ///
    /// stocker l'image choisie dans la galerie
    final XFile? file = await getImages.fromGallery();

    debugPrint('>>>>>>>>>>>>>>>>>${file?.name}');

    emit(state.copyWith(
      file: file,
      isValid: Formz.validate([state.firstName, state.lastName]),
    ));
  }

  void _firstNameChangedEvent(
      ProfileFirstNameChangedEvent event, Emitter<ProfileState> emit) {
    final firstname = Name.dirty(event.firstname.trim());

    debugPrint('firstname changed: >>>>>>>>>>>> $firstname');
    emit(state.copyWith(
      firstName: firstname,
      isValid: Formz.validate([firstname]),
    ));
  }

  void _lastNameChangedEvent(
      ProfileLastNameChangedEvent event, Emitter<ProfileState> emit) {
    final lastname = Name.dirty(event.lastname.trim());

    debugPrint('lastname changed: >>>>>>>>>>>> $lastname');

    emit(state.copyWith(
      lastName: lastname,
      isValid: Formz.validate([lastname]),
    ));
  }

  Future<UserModel?> _tryGetUser() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var userData = pref.getString('userData');
      // var token = pref.getString('token');
      debugPrint(
          'userData _tryGetUser:::::::::::::::: Data cached :::::::::::::::::');
      debugPrint('$userData');

      if (userData != null) {
        var decodedData = jsonDecode(userData);
        final user = UserModel.fromJson(decodedData);
        return user;
      } else {
        debugPrint('::::::::::::::::: Nothing cached :::::::::::::::::');
        return null;
      }
    } catch (e) {
      debugPrint(
          'Une erreur s\'est produite lors de la récupération des données utilisateur en cache:: \n$e');
      return null;
    }
  }

  Future<UserModel?> _tryGetUser2() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var userData = pref.getString('userData');
    // var token = pref.getString('token');

    if (userData != null) {
      var decodedData = jsonDecode(userData);
      final user = UserModel.fromJson(decodedData);
      return user;
    }
    return null;
  }

  FutureOr<void> _phoneNumberChangedEvent(
      ProfilePhoneNumberChangedEvent event, Emitter<ProfileState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);

    debugPrint('phoneNumber changed: >>>>>>>>>>>> $phoneNumber');

    emit(state.copyWith(
      phoneNumber: phoneNumber,
      isValid: Formz.validate([phoneNumber]),
    ));
  }

  void _submitForm(SubmitForm event, Emitter<ProfileState> emit) async {
    if (state.isValid) {
      try {
        emit(state.copyWith(
            status: FormzSubmissionStatus.inProgress,
            pathName: state.pathName));
        debugPrint('user request ::::::::::::::::::::::::: ${state.file}');

        debugPrint('profile::::: ${state.file}');
        debugPrint('firstName::::: ${state.firstName.value}');
        debugPrint('lastName::::: ${state.lastName.value}');
        bool success = await Authentication.updateUser(
          lastName: state.lastName.value,
          firstName: state.firstName.value,
          phoneNumber: state.phoneNumber.value,
          image: state.file,
        );
        if (success) {
          var json = await _tryGetUser();
          debugPrint('_tryGetUser::::: ${json!.toJson()}');
          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            isValid: success,
            user: json,
          ));

          debugPrint('state.file::::: ${state.file}');
        } else {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            isValid: success,
          ));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
        ));
      }
    }
  }

  void _onUpdateEvent(
      ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    final user = await _tryGetUser();
    final user2 = await _tryGetUser2();
    if (user != null) {
      // add(AuthenticationStatusChanged(AuthenticationStatus.authenticated));
      // add(ProfileFirstNameChangedEvent(user.firstname));
      // add(ProfileLastNameChangedEvent(user.lastname));

      emit(state.copyWith(
          firstName: Name.dirty(user.firstName ?? ''),
          lastName: Name.dirty(user.lastName ?? ''),
          phoneNumber: PhoneNumber.dirty(user.userNumber ?? ''),
          user: user2));
    }
  }

  void _initialEvent(Initial event, Emitter<ProfileState> emit) {
    emit(
      state.copyWith(status: FormzSubmissionStatus.initial),
    );
  }
}
