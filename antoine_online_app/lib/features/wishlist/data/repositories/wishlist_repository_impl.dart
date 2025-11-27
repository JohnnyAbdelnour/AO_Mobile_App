import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/wishlist/data/datasources/wishlist_remote_datasource.dart';
import 'package:antoine_online_app/features/wishlist/data/models/add_wishlist_item_request.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist_item.dart';
import 'package:antoine_online_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:antoine_online_app/core/network/magento_api_exception.dart';
import 'package:dio/dio.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Wishlist>> getWishlist() async {
    try {
      final wishlistDto = await remoteDataSource.getWishlist();
      return Right(wishlistDto.toDomain());
    } on MagentoApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioError catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred.'));
    }
  }

  @override
  Future<Either<Failure, WishlistItem>> addItem({
    required String sku,
    int qty = 1,
  }) async {
    try {
      final request = AddWishlistItemRequest(sku: sku, qty: qty);
      final wishlistItemDto = await remoteDataSource.addItem(request);
      return Right(wishlistItemDto.toDomain());
    } on MagentoApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioError catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred.'));
    }
  }

  @override
  Future<Either<Failure, void>> removeItem({
    required int wishlistItemId,
  }) async {
    try {
      await remoteDataSource.removeItem(wishlistItemId);
      return Right(null);
    } on MagentoApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioError catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred.'));
    }
  }

  @override
  Future<Either<Failure, void>> clearWishlist() async {
    try {
      await remoteDataSource.clearWishlist();
      return Right(null);
    } on MagentoApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioError catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred.'));
    }
  }
}
