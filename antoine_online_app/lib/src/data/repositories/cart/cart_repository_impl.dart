import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:antoine_online_app/src/domain/repositories/cart_repository.dart';
import 'package:antoine_online_app/src/data/api/magento_api_client.dart';
import 'package:antoine_online_app/src/data/models/cart/cart.dart';

class CartRepositoryImpl implements CartRepository {
  final MagentoApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;
  final Box _cartBox;
  static const _guestCartIdKey = 'guest_cart_id';

  CartRepositoryImpl(this._apiClient, this._secureStorage, this._cartBox);

  Future<String> _getCartId() async {
    final isLoggedIn = await _secureStorage.read(key: 'auth_token') != null;
    if (isLoggedIn) {
      // For logged in customer, cart is managed via 'me' endpoints
      return 'mine';
    } else {
      // For guest, we need to create a cart and store its ID
      var cartId = _cartBox.get(_guestCartIdKey);
      if (cartId == null) {
        final response = await _apiClient.post('/guest-carts');
        cartId = response.data;
        await _cartBox.put(_guestCartIdKey, cartId);
      }
      return cartId;
    }
  }

  @override
  Future<Cart> getCart() async {
    final cartId = await _getCartId();
    final response = await _apiClient.get('/carts/$cartId');
    return Cart.fromJson(response.data);
  }

  @override
  Future<void> addToCart(String sku, int qty) async {
    final cartId = await _getCartId();
    await _apiClient.post(
      '/carts/$cartId/items',
      data: {
        'cartItem': {'sku': sku, 'qty': qty}
      },
    );
  }

  @override
  Future<void> removeFromCart(int itemId) async {
    final cartId = await _getCartId();
    await _apiClient.post('/carts/$cartId/items/$itemId');
  }

  @override
  Future<void> updateItemQty(int itemId, int qty) async {
    final cartId = await _getCartId();
    await _apiClient.post(
      '/carts/$cartId/items/$itemId',
      data: {
        'cartItem': {'qty': qty}
      },
    );
  }
}
