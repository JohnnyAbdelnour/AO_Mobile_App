import 'package:antoine_online_app/src/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  AddToCartUseCase(this._repository);

  Future<void> call(String sku, int qty) {
    return _repository.addToCart(sku, qty);
  }
}
