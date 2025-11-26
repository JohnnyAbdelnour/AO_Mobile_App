import 'package:antoine_online_app/src/domain/repositories/account_repository.dart';
import 'package:antoine_online_app/src/data/models/account/order.dart';

class GetOrdersUseCase {
  final AccountRepository _repository;

  GetOrdersUseCase(this._repository);

  Future<List<Order>> call() {
    return _repository.getOrders();
  }
}
