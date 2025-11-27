import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/src/presentation/providers/account/account_providers.dart';
 feature/antoine-online-mvp-clean
import 'package:go_router/go_router.dart';

import 'package:antoine_online_app/src/presentation/screens/orders/order_history_screen.dart';
main

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: customer.when(
        data: (data) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
feature/antoine-online-mvp-clean
            crossAxisAlignment: CrossAxisAlignment.start,

 feature/antoine-online-mvp-final
            crossAxisAlignment: CrossAxisAlignment.start,

            crossAxisAlignment: CrossAxisAlignment: CrossAxisAlignment.start,
 main
main
            children: [
              Text('Name: ${data.firstname} ${data.lastname}'),
              Text('Email: ${data.email}'),
              ElevatedButton(
feature/antoine-online-mvp-clean
                onPressed: () => context.go('/orders'),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryScreen(),
                    ),
                  );
                },
main
                child: const Text('Order History'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
