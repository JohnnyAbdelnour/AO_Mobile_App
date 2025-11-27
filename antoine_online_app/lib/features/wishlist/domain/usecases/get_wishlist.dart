import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/repositories/wishlist_repository.dart';

class GetWishlist {
  final WishlistRepository repository;

  GetWishlist(this.repository);

  Future<Either<Failure, Wishlist>> call() async {
    return await repository.getWishlist();
  }
}
