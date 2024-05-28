part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;

  //TODO
  //Ultimo geo-location
  //History

  const LocationState({this.followingUser = false});

  @override
  List<Object> get props => [followingUser];
}
