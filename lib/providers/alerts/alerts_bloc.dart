import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mafuriko/models/alert.models.dart';

part 'alerts_event.dart';
part 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertsEvent,AlertsState>{

  
   AlertsBloc(): super(AlertsFetchedSuccessState(const [])){

    on<FetchFloodAlerts >(_fetchFloodAlerts);

  }


  FutureOr<void> _fetchFloodAlerts(FetchFloodAlerts event, Emitter<AlertsState> emit) {
  }
}
