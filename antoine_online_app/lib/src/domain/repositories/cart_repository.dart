import 'package:antoine_online_app/src/data/models/cart/cart.dart';

abstract class CartRepository {
  Future<Cart> getCart();
  Future<void> addToCart(String sku, int qty);
  Future<void> removeFromCart(int itemId);
  Future<void> updateItemQty(int itemId, int qty);
}
