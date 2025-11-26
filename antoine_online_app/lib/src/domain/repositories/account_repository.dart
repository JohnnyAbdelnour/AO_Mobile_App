import 'package:antoine_online_app/src/data/models/account/customer.dart';
import 'package:antoine_online_app/src/data/models/account/order.dart';

abstract class AccountRepository {
  Future<Customer> getCustomer();
  Future<List<Order>> getOrders();
}
