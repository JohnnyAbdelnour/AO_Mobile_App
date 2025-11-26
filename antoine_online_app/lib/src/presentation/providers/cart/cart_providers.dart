import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:antoine_online_app/src/data/repositories/cart/cart_repository_impl.dart';
import 'package:antoine_online_app/src/domain/repositories/cart_repository.dart';
import 'package:antoine_online_app/src/domain/usecases/cart/add_to_cart_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/cart/get_cart_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/cart/remove_from_cart_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/cart/update_item_qty_use_case.dart';
import 'package:antoine_online_app/src/presentation/providers/auth/auth_providers.dart';
import 'package:antoine_online_app/src/data/models/cart/cart.dart';

final cartBoxProvider = Provider<Box>((ref) => Hive.box('cart'));

final cartRepositoryProvider = Provider<CartRepository>((ref) => CartRepositoryImpl(
      ref.read(apiClientProvider),
      ref.read(secureStorageProvider),
      ref.read(cartBoxProvider),
    ));

final getCartUseCaseProvider = Provider((ref) => GetCartUseCase(ref.read(cartRepositoryProvider)));
final addToCartUseCaseProvider = Provider((ref) => AddToCartUseCase(ref.read(cartRepositoryProvider)));
final removeFromCartUseCaseProvider = Provider((ref) => RemoveFromCartUseCase(ref.read(cartRepositoryProvider)));
final updateItemQtyUseCaseProvider = Provider((ref) => UpdateItemQtyUseCase(ref.read(cartRepositoryProvider)));

final cartProvider = StateNotifierProvider<CartNotifier, AsyncValue<Cart>>((ref) {
  return CartNotifier(ref);
});

class CartNotifier extends StateNotifier<AsyncValue<Cart>> {
  final Ref _ref;

  CartNotifier(this._ref) : super(const AsyncValue.loading()) {
    _getCart();
  }

  Future<void> _getCart() async {
    try {
      final cart = await _ref.read(getCartUseCaseProvider).call();
      state = AsyncValue.data(cart);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addToCart(String sku, int qty) async {
    await _ref.read(addToCartUseCaseProvider).call(sku, qty);
    _getCart();
  }

  Future<void> removeFromCart(int itemId) async {
    await _ref.read(removeFromCartUseCaseProvider).call(itemId);
    _getCart();
  }

  Future<void> updateItemQty(int itemId, int qty) async {
    await _ref.read(updateItemQtyUseCaseProvider).call(itemId, qty);
    _getCart();
  }
}
