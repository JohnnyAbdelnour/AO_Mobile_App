import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/src/presentation/providers/catalog/catalog_providers.dart';

class ProductSearchScreen extends ConsumerWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => ref.read(searchProvider.notifier).state = value,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: searchResults.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final product = data[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
