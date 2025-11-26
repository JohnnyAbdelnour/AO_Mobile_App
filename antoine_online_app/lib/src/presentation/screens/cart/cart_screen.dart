import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/src/presentation/providers/cart/cart_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.when(
        data: (data) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.items.length,
                itemBuilder: (context, index) {
                  final item = data.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Qty: ${item.qty}'),
                    trailing: Text('\$${item.price * item.qty}'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Grand Total:', style: TextStyle(fontSize: 20)),
                  Text('\$${data.grandTotal}', style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to checkout
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
