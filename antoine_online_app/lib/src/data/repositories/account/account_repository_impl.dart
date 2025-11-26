import 'package:antoine_online_app/src/domain/repositories/account_repository.dart';
import 'package:antoine_online_app/src/data/api/magento_api_client.dart';
import 'package:antoine_online_app/src/data/models/account/customer.dart';
import 'package:antoine_online_app/src/data/models/account/order.dart';

class AccountRepositoryImpl implements AccountRepository {
  final MagentoApiClient _apiClient;

  AccountRepositoryImpl(this._apiClient);

  @override
  Future<Customer> getCustomer() async {
    final response = await _apiClient.get('/customers/me');
    return Customer.fromJson(response.data);
  }

  @override
  Future<List<Order>> getOrders() async {
    final response = await _apiClient.get(
      '/orders',
      queryParameters: {
        'searchCriteria[filter_groups][0][filters][0][field]': 'customer_id',
        'searchCriteria[filter_groups][0][filters][0][value]': 'me',
      },
    );
    final data = response.data['items'] as List;
    return data.map((order) => Order.fromJson(order)).toList();
  }
}
