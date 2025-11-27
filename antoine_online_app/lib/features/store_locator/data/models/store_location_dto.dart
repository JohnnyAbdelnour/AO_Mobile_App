// lib/features/store_locator/data/models/store_location_dto.dart
import 'package:antoine_online_app/features/store_locator/domain/entities/store_location.dart';
import 'package:antoine_online_app/features/store_locator/domain/entities/opening_hours.dart';
import 'opening_hours_dto.dart';

class StoreLocationDto {
  final int id;
  final String name;
  final String address;
  final String? phone;
  final String? email;
  final double latitude;
  final double longitude;
  final OpeningHoursDto? openingHours;

  const StoreLocationDto({
    required this.id,
    required this.name,
    required this.address,
    this.phone,
    this.email,
    required this.latitude,
    required this.longitude,
    this.openingHours,
  });

  factory StoreLocationDto.fromJson(Map<String, dynamic> json) {
    return StoreLocationDto(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      openingHours: json['opening_hours'] != null
          ? OpeningHoursDto.fromJson(json['opening_hours'] as Map<String, dynamic>)
          : null,
    );
  }

  StoreLocation toDomain() {
    return StoreLocation(
      id: id,
      name: name,
      address: address,
      phone: phone,
      email: email,
      latitude: latitude,
      longitude: longitude,
      openingHours: openingHours?.toDomain(),
    );
  }
}
