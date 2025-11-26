import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/src/data/repositories/account/account_repository_impl.dart';
import 'package:antoine_online_app/src/domain/repositories/account_repository.dart';
import 'package:antoine_online_app/src/domain/usecases/account/get_customer_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/account/get_orders_use_case.dart';
import 'package:antoine_online_app/src/presentation/providers/auth/auth_providers.dart';
import 'package:antoine_online_app/src/data/models/account/customer.dart';
import 'package:antoine_online_app/src/data/models/account/order.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref) => AccountRepositoryImpl(ref.read(apiClientProvider)));

final getCustomerUseCaseProvider = Provider((ref) => GetCustomerUseCase(ref.read(accountRepositoryProvider)));
final getOrdersUseCaseProvider = Provider((ref) => GetOrdersUseCase(ref.read(accountRepositoryProvider)));

final customerProvider = FutureProvider<Customer>((ref) async {
  return ref.read(getCustomerUseCaseProvider).call();
});

final ordersProvider = FutureProvider<List<Order>>((ref) async {
  return ref.read(getOrdersUseCaseProvider).call();
});
