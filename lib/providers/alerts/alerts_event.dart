part of 'alerts_bloc.dart';

sealed class AlertsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchFloodAlerts extends AlertsEvent {
  @override
  List<Object?> get props => [];
}

class SendFloodAlerts extends AlertsEvent {
  @override
  List<Object?> get props => [];
}

class AlertLocationChanged extends AlertsEvent {
  final LatLng position;

  AlertLocationChanged({required this.position});

  @override
  List<Object?> get props => [position];
}

class AlertLocationTypedChanged extends AlertsEvent {
  final String location;

  AlertLocationTypedChanged({required this.location});

  @override
  List<Object?> get props => [location];
}

class AlertDescriptionChanged extends AlertsEvent {
  final String desc;

  AlertDescriptionChanged({this.desc = ""});

  @override
  List<Object?> get props => [desc];
}

class AlertIntensityChanged extends AlertsEvent {
  final String value;

  AlertIntensityChanged({required this.value});
}

class PickAlertImage extends AlertsEvent {
  @override
  List<Object?> get props => [];
}

class AlertResetEventForm extends AlertsEvent {
  @override
  List<Object?> get props => [];
}
    // required LatLng position,
    // required String description,
    // required String intensity,
    // required XFile image,