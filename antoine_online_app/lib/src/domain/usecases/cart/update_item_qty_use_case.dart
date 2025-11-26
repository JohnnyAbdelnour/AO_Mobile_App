import 'package:antoine_online_app/src/domain/repositories/cart_repository.dart';

class UpdateItemQtyUseCase {
  final CartRepository _repository;

  UpdateItemQtyUseCase(this._repository);

  Future<void> call(int itemId, int qty) {
    return _repository.updateItemQty(itemId, qty);
  }
}
