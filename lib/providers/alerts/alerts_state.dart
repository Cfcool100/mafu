part of 'alerts_bloc.dart';

sealed class AlertsState extends Equatable {}

class AlertsFetchedSuccessState extends AlertsState {
  final List<FloodAlert> alerts;

  AlertsFetchedSuccessState(this.alerts);
  @override
  List<Object?> get props => [];
}
