import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/src/presentation/providers/account/account_providers.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: orders.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final order = data[index];
            return ListTile(
              title: Text('Order #${order.incrementId}'),
              subtitle: Text('Status: ${order.status}'),
              trailing: Text('\$${order.grandTotal}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
