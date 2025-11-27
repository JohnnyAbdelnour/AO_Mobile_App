// lib/features/wishlist/data/models/wishlist_dto.dart
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist_item.dart';
import 'wishlist_item_dto.dart';

class WishlistDto {
  final int id;
  final List<WishlistItemDto> items;

  const WishlistDto({
    required this.id,
    required this.items,
  });

  factory WishlistDto.fromJson(Map<String, dynamic> json) {
    return WishlistDto(
      id: json['id'] as int,
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => WishlistItemDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Wishlist toDomain() {
    return Wishlist(
      id: id,
      items: items.map((e) => e.toDomain()).toList(),
    );
  }
}
