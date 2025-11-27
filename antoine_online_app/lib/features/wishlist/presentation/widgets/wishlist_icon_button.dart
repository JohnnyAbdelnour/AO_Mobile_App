import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/features/wishlist/presentation/providers/wishlist_notifier.dart';

class WishlistIconButton extends ConsumerWidget {
  final String sku;

  const WishlistIconButton({super.key, required this.sku});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final isAdded = wishlist.asData?.value.items.any((item) => item.sku == sku) ?? false;

    return IconButton(
      icon: Icon(
        isAdded ? Icons.favorite : Icons.favorite_border,
        color: isAdded ? Colors.red : null,
      ),
      onPressed: () {
        if (isAdded) {
          final itemId = wishlist.asData!.value.items.firstWhere((item) => item.sku == sku).id;
          ref.read(wishlistProvider.notifier).remove(itemId);
        } else {
          ref.read(wishlistProvider.notifier).add(sku);
        }
      },
    );
  }
}
