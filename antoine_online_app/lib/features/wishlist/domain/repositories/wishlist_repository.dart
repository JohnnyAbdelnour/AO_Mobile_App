// lib/features/wishlist/domain/repositories/wishlist_repository.dart
import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist_item.dart';

abstract class WishlistRepository {
  /// Get the current customer's wishlist.
  Future<Either<Failure, Wishlist>> getWishlist();

  /// Add an item to the wishlist by SKU.
  /// qty defaults to 1 if not provided.
  Future<Either<Failure, WishlistItem>> addItem({
    required String sku,
    int qty = 1,
  });

  /// Remove an item from wishlist by wishlist item id.
  Future<Either<Failure, void>> removeItem({
    required int wishlistItemId,
  });

  /// Optional: clear whole wishlist
  Future<Either<Failure, void>> clearWishlist();
}
