import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;

  GpsBloc()
      : super(const GpsState(
            isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsPermissionEvent>((event, emit) => emit(state.copyWith(
          isGpsEnabled: event.isGpsEnabled,
          isGpsPermissionGranted: event.isGpsPermissionGranted,
        )));

    _init();
  }

  Future<void> _init() async {
    final isEnabled = await _checkGpsStatus();
    print('isEnable: $isEnabled');

    add(GpsPermissionEvent(
        isGpsPermissionGranted: state.isGpsPermissionGranted,
        isGpsEnabled: isEnabled));
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;

      add(GpsPermissionEvent(
          isGpsPermissionGranted: state.isGpsPermissionGranted,
          isGpsEnabled: isEnabled));
    });

    return isEnable;
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
