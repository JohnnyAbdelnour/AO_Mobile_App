// lib/features/wishlist/domain/entities/wishlist.dart
import 'wishlist_item.dart';

class Wishlist {
  final int id;
  final List<WishlistItem> items;

  const Wishlist({
    required this.id,
    required this.items,
  });

  bool get isEmpty => items.isEmpty;
  int get totalItems => items.length;
}
