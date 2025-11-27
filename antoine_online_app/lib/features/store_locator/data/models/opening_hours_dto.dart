// lib/features/store_locator/data/models/opening_hours_dto.dart
import 'package:antoine_online_app/features/store_locator/domain/entities/opening_hours.dart';

class OpeningHoursDto {
  final String? monFri;
  final String? saturday;
  final String? sunday;

  const OpeningHoursDto({
    this.monFri,
    this.saturday,
    this.sunday,
  });

  factory OpeningHoursDto.fromJson(Map<String, dynamic> json) {
    return OpeningHoursDto(
      monFri: json['mon_fri'] as String?,
      saturday: json['sat'] as String?,
      sunday: json['sun'] as String?,
    );
  }

  OpeningHours toDomain() {
    return OpeningHours(
      mondayToFriday: monFri,
      saturday: saturday,
      sunday: sunday,
    );
  }
}
