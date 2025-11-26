import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/src/presentation/providers/account/account_providers.dart';
import 'package:go_router/go_router.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${data.firstname} ${data.lastname}'),
              Text('Email: ${data.email}'),
              ElevatedButton(
                onPressed: () => context.go('/orders'),
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
