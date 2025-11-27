import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/wishlist/domain/repositories/wishlist_repository.dart';

class RemoveFromWishlist {
  final WishlistRepository repository;

  RemoveFromWishlist(this.repository);

  Future<Either<Failure, void>> call({
    required int wishlistItemId,
  }) async {
    return await repository.removeItem(wishlistItemId: wishlistItemId);
  }
}
