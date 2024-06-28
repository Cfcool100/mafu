part of 'alerts_bloc.dart';

// enum AlertStatus { unknown, initial, progress, done, failed, cancelled }

class AlertsState extends Equatable {
  final List<FloodAlert> alerts;
  final LatLng position;
  final String locationTyped;
  final String intensity;
  final String description;
  final XFile? file;
  final String? filePathName;
  final FormzSubmissionStatus? status;
  final bool isValid;

  const AlertsState({
    this.alerts = const [],
    this.position = const LatLng(0, 0),
    this.locationTyped = '',
    this.intensity = '',
    this.description = '',
    this.file,
    this.filePathName,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });
  @override
  List<Object?> get props => [
        alerts,
        position,
        locationTyped,
        intensity,
        description,
        file,
        filePathName,
        status,
        isValid,
      ];

  factory AlertsState.initial() {
    return const AlertsState();
  }

  AlertsState copyWith({
    List<FloodAlert>? alerts,
    LatLng? position,
    String? locationTyped,
    String? intensity,
    String? description,
    XFile? file,
    String? filePathName,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return AlertsState(
      alerts: alerts ?? this.alerts,
      position: position ?? this.position,
      locationTyped: locationTyped ?? this.locationTyped,
      intensity: intensity ?? this.intensity,
      description: description ?? this.description,
      file: file ?? this.file,
      filePathName: filePathName ?? this.filePathName,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}



// class AlertsFetchedSuccessState extends AlertsState {
//   final List<FloodAlert> alerts;

//   AlertsFetchedSuccessState(this.alerts);
//   @override
//   List<Object?> get props => [];
// }
