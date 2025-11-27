import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/features/wishlist/presentation/providers/wishlist_notifier.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistState = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: wishlistState.when(
        data: (wishlist) {
          if (wishlist.isEmpty) {
            return const Center(child: Text('Your wishlist is empty.'));
          }
          return ListView.builder(
            itemCount: wishlist.items.length,
            itemBuilder: (context, index) {
              final item = wishlist.items[index];
              return ListTile(
                leading: item.imageUrl != null ? Image.network(item.imageUrl!) : null,
                title: Text(item.name),
                subtitle: Text('\$${item.price}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    ref.read(wishlistProvider.notifier).remove(item.id);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
