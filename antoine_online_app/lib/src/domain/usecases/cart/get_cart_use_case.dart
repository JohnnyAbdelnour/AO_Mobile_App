import 'package:antoine_online_app/src/domain/repositories/cart_repository.dart';
import 'package:antoine_online_app/src/data/models/cart/cart.dart';

class GetCartUseCase {
  final CartRepository _repository;

  GetCartUseCase(this._repository);

  Future<Cart> call() {
    return _repository.getCart();
  }
}
