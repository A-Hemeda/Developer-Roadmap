import 'package:equatable/equatable.dart';

class UserSearchEntity extends Equatable {
  final String address;
  final String maxPrice;
  final String minPrice;
  final String facilities0;
  final String facilities1;
  final String latitude;
  final String longitude;
  final String distance;
  final String name;

  const UserSearchEntity({
    required this.address,
    required this.maxPrice,
    required this.minPrice,
    required this.facilities0,
    required this.facilities1,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.name,
  });

  @override
  List<Object> get props => [
        address,
        maxPrice,
        minPrice,
        facilities0,
        facilities1,
        latitude,
        longitude,
        distance,
        name,
      ];
}
