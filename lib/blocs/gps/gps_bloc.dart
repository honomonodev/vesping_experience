import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
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
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      print('service status: $isEnabled ');
    });

    return isEnable;
  }

  @override
  Future<void> close() {
    // TODO: limpiar ServiceStatus Stream
    return super.close();
  }
}
