part of 'alerts_bloc.dart';

sealed class AlertsEvent extends Equatable {}

class FetchFloodAlerts extends AlertsEvent {
  @override
  List<Object?> get props => [];
}
