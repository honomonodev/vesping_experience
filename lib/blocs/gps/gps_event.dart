part of 'gps_bloc.dart';

sealed class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsPermissionEvent extends GpsEvent {
  final bool isGpsPermissionGranted;
  final bool isGpsEnabled;

  const GpsPermissionEvent(
      {required this.isGpsPermissionGranted, required this.isGpsEnabled});
}
