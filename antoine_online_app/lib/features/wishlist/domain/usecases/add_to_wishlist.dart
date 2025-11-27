import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist_item.dart';
import 'package:antoine_online_app/features/wishlist/domain/repositories/wishlist_repository.dart';

class AddToWishlist {
  final WishlistRepository repository;

  AddToWishlist(this.repository);

  Future<Either<Failure, WishlistItem>> call({
    required String sku,
    int qty = 1,
  }) async {
    return await repository.addItem(sku: sku, qty: qty);
  }
}
