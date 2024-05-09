import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsPermissionEvent(
            isGpsPermissionGranted: true, isGpsEnabled: state.isGpsEnabled));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsPermissionEvent(
            isGpsPermissionGranted: false, isGpsEnabled: state.isGpsEnabled));
        openAppSettings();
        break;
      default:
        break;
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
