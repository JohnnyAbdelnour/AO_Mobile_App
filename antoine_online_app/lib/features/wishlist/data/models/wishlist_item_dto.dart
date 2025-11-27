// lib/features/wishlist/data/models/wishlist_item_dto.dart
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist_item.dart';

class WishlistItemDto {
  final int id;
  final String sku;
  final String name;
  final String? imageUrl;
  final double price;
  final double? specialPrice;
  final int qty;
  final DateTime addedAt;

  const WishlistItemDto({
    required this.id,
    required this.sku,
    required this.name,
    this.imageUrl,
    required this.price,
    this.specialPrice,
    required this.qty,
    required this.addedAt,
  });

  factory WishlistItemDto.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>? ?? {};
    final thumbnail = product['thumbnail'] as String?;
    final addedAtRaw = json['added_at'] as String?;

    return WishlistItemDto(
      id: json['id'] as int,
      sku: json['sku'] as String,
      name: product['name'] as String? ?? '',
      imageUrl: thumbnail != null && thumbnail.isNotEmpty
          ? thumbnail
          : null,
      price: (product['price'] as num?)?.toDouble() ?? 0.0,
      specialPrice:
          product['special_price'] != null ? (product['special_price'] as num).toDouble() : null,
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      addedAt: addedAtRaw != null
          ? DateTime.parse(addedAtRaw.replaceFirst(' ', 'T'))
          : DateTime.now(),
    );
  }

  WishlistItem toDomain() {
    return WishlistItem(
      id: id,
      sku: sku,
      name: name,
      imageUrl: imageUrl,
      price: price,
      specialPrice: specialPrice,
      qty: qty,
      addedAt: addedAt,
    );
  }
}
