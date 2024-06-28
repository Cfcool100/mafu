import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/controllers/alert.controller.dart';
import 'package:mafuriko/models/alert.models.dart';
import 'package:mafuriko/utils/files_picker.dart';

part 'alerts_event.dart';
part 'alerts_state.dart';

final FilesPicker getImages = FilesPicker();

class AlertsBloc extends Bloc<AlertsEvent, AlertsState> {
  AlertsBloc() : super(AlertsState.initial()) {
    on<FetchFloodAlerts>(_fetchFloodAlerts);
    on<AlertLocationChanged>(_onLocationChange);
    on<AlertLocationTypedChanged>(_onLocationTypedChange);
    on<AlertDescriptionChanged>(_onDescriptionChange);
    on<AlertIntensityChanged>(_onIntensityChange);
    on<PickAlertImage>(_onPickAlertImage);
    on<SendFloodAlerts>(_sendFloodAlerts);
    on<AlertResetEventForm>(_resetEventForm);
  }

  // isValid: event.value.isNotEmpty && state.locationTyped.isNotEmpty

  Future<FutureOr<void>> _fetchFloodAlerts(
      FetchFloodAlerts event, Emitter<AlertsState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final List<FloodAlert> data = await Alert.fetchAlert();

      if (data.isNotEmpty) {
        debugPrint('''
::::::::::::::::::::::::::::::::::::::::
:::::::::::: DATA FETCHED:::::::::::::::
::::::::::::::::::::::::::::::::::::::::
::::::::::::             :::::::::::::::
::::::::::::\t\t $data \t:::::::::::::::
::::::::::::             :::::::::::::::
::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::
''');
        emit(state.copyWith(
            alerts: data, status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(alerts: [], status: FormzSubmissionStatus.failure));
      }
    } on Exception catch (e) {
      emit(state.copyWith(alerts: [], status: FormzSubmissionStatus.failure));
      debugPrint(e.toString());
    }
  }

  FutureOr<void> _onDescriptionChange(
      AlertDescriptionChanged event, Emitter<AlertsState> emit) {
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: description typing.. : ${event.desc}');
    emit(state.copyWith(description: event.desc));
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: state description typing.. : ${state.description}');
  }

  FutureOr<void> _onIntensityChange(
      AlertIntensityChanged event, Emitter<AlertsState> emit) {
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: intensity value change.. : ${event.value}');

    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: before intensity state value change.. : ${state.intensity}');
    emit(state.copyWith(
        intensity: event.value,
        isValid:
            event.value.isNotEmpty && state.position != const LatLng(0, 0)));
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: intensity state value change.. : ${state.intensity}');
  }

  Future<FutureOr<void>> _onPickAlertImage(
      PickAlertImage event, Emitter<AlertsState> emit) async {
    final XFile? file = await getImages.fromGallery();
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: image flood picked.. : ${file?.path}');
    emit(state.copyWith(
      file: file,
      filePathName: file?.name,
    ));
  }

  Future<FutureOr<void>> _sendFloodAlerts(
      SendFloodAlerts event, Emitter<AlertsState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final success = await Alert.sendAlert(
          location: state.locationTyped,
          position: state.position,
          description: state.description,
          intensity: state.intensity,
          image: state.file,
        );

        if (success) {
          debugPrint(
              '::::::::::::::::::::::\n<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>> request was $success');
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      } on Exception catch (e) {
        debugPrint(
            '::::::::::::::::::::::\n<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>> $e');
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  FutureOr<void> _resetEventForm(
      AlertResetEventForm event, Emitter<AlertsState> emit) {
    emit(AlertsState.initial());
  }

  FutureOr<void> _onLocationChange(
      AlertLocationChanged event, Emitter<AlertsState> emit) {
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: location ... : ${event.position}');
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: intensity ... : ${state.intensity}');
    emit(state.copyWith(
        position: event.position,
        intensity: state.intensity,
        isValid: state.intensity.isNotEmpty &&
            event.position != const LatLng(0, 0)));
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: intensity after location change ... : ${state.intensity}');
  }

  FutureOr<void> _onLocationTypedChange(
      AlertLocationTypedChanged event, Emitter<AlertsState> emit) {
    debugPrint(
        ':::::::::::::::::::::::::::::::::::::: location typed by user ... : ${event.location}');
    emit(state.copyWith(locationTyped: event.location));
  }
}
