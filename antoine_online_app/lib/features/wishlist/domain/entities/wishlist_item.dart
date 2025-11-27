// lib/features/wishlist/domain/entities/wishlist_item.dart
class WishlistItem {
  final int id;          // wishlist item id (not product id)
  final String sku;
  final String name;
  final String? imageUrl;
  final double price;
  final double? specialPrice;
  final int qty;
  final DateTime addedAt;

  const WishlistItem({
    required this.id,
    required this.sku,
    required this.name,
    this.imageUrl,
    required this.price,
    this.specialPrice,
    required this.qty,
    required this.addedAt,
  });
}
