// lib/features/store_locator/domain/entities/store_location.dart
import 'opening_hours.dart';

class StoreLocation {
  final int id;
  final String name;
  final String address;
  final String? phone;
  final String? email;
  final double latitude;
  final double longitude;
  final OpeningHours? openingHours;

  const StoreLocation({
    required this.id,
    required this.name,
    required this.address,
    this.phone,
    this.email,
    required this.latitude,
    required this.longitude,
    this.openingHours,
  });
}
