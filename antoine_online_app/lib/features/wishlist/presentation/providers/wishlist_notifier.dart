import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/usecases/add_to_wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/usecases/remove_from_wishlist.dart';
import 'package:antoine_online_app/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:antoine_online_app/features/wishlist/data/datasources/wishlist_remote_datasource.dart';
import 'package:antoine_online_app/src/presentation/providers/auth/auth_providers.dart';

final wishlistRemoteDataSourceProvider = Provider<WishlistRemoteDataSource>((ref) {
  return WishlistRemoteDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});

final wishlistRepositoryProvider = Provider<WishlistRepositoryImpl>((ref) {
  return WishlistRepositoryImpl(remoteDataSource: ref.watch(wishlistRemoteDataSourceProvider));
});

final getWishlistProvider = Provider<GetWishlist>((ref) {
  return GetWishlist(ref.watch(wishlistRepositoryProvider));
});

final addToWishlistProvider = Provider<AddToWishlist>((ref) {
  return AddToWishlist(ref.watch(wishlistRepositoryProvider));
});

final removeFromWishlistProvider = Provider<RemoveFromWishlist>((ref) {
  return RemoveFromWishlist(ref.watch(wishlistRepositoryProvider));
});


final wishlistProvider = StateNotifierProvider<WishlistNotifier, AsyncValue<Wishlist>>((ref) {
  return WishlistNotifier(
    ref.watch(getWishlistProvider),
    ref.watch(addToWishlistProvider),
    ref.watch(removeFromWishlistProvider),
  );
});

class WishlistNotifier extends StateNotifier<AsyncValue<Wishlist>> {
  final GetWishlist _getWishlist;
  final AddToWishlist _addToWishlist;
  final RemoveFromWishlist _removeFromWishlist;

  WishlistNotifier(
    this._getWishlist,
    this._addToWishlist,
    this._removeFromWishlist,
  ) : super(const AsyncValue.loading()) {
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    final result = await _getWishlist();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (wishlist) => state = AsyncValue.data(wishlist),
    );
  }

  Future<void> add(String sku) async {
    final result = await _addToWishlist(sku: sku);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (item) => loadWishlist(), // Invalidate and refetch
    );
  }

  Future<void> remove(int wishlistItemId) async {
    final result = await _removeFromWishlist(wishlistItemId: wishlistItemId);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => loadWishlist(), // Invalidate and refetch
    );
  }
}
