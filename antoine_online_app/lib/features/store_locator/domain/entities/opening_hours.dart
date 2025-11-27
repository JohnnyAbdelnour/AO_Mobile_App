// lib/features/store_locator/domain/entities/opening_hours.dart
class OpeningHours {
  final String? mondayToFriday;
  final String? saturday;
  final String? sunday;

  const OpeningHours({
    this.mondayToFriday,
    this.saturday,
    this.sunday,
  });
}
