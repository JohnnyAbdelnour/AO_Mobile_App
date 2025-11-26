import 'package:antoine_online_app/src/domain/repositories/account_repository.dart';
import 'package:antoine_online_app/src/data/models/account/customer.dart';

class GetCustomerUseCase {
  final AccountRepository _repository;

  GetCustomerUseCase(this._repository);

  Future<Customer> call() {
    return _repository.getCustomer();
  }
}
