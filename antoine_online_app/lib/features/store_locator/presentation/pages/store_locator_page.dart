import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/features/store_locator/presentation/providers/store_locator_notifier.dart';
import 'package:antoine_online_app/features/store_locator/presentation/widgets/store_card.dart';

class StoreLocatorPage extends ConsumerWidget {
  const StoreLocatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeLocatorState = ref.watch(storeLocatorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Locator'),
      ),
      body: storeLocatorState.when(
        data: (storeLocations) {
          if (storeLocations.isEmpty) {
            return const Center(child: Text('No stores found.'));
          }
          return ListView.builder(
            itemCount: storeLocations.length,
            itemBuilder: (context, index) {
              final store = storeLocations[index];
              return StoreCard(store: store);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
