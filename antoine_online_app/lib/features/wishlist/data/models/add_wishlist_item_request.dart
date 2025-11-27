// lib/features/wishlist/data/models/add_wishlist_item_request.dart
class AddWishlistItemRequest {
  final String sku;
  final int qty;

  AddWishlistItemRequest({
    required this.sku,
    this.qty = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'wishlistItem': {
        'sku': sku,
        'qty': qty,
      },
    };
  }
}
