import 'package:antoine_online_app/core/network/magento_api_client.dart';
import 'package:antoine_online_app/features/wishlist/data/models/add_wishlist_item_request.dart';
import 'package:antoine_online_app/features/wishlist/data/models/wishlist_dto.dart';
import 'package:antoine_online_app/features/wishlist/data/models/wishlist_item_dto.dart';

abstract class WishlistRemoteDataSource {
  Future<WishlistDto> getWishlist();
  Future<WishlistItemDto> addItem(AddWishlistItemRequest request);
  Future<void> removeItem(int wishlistItemId);
  Future<void> clearWishlist();
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final MagentoApiClient apiClient;

  WishlistRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<WishlistDto> getWishlist() async {
    final response = await apiClient.get('/wishlists/mine');
    return WishlistDto.fromJson(response.data);
  }

  @override
  Future<WishlistItemDto> addItem(AddWishlistItemRequest request) async {
    final response = await apiClient.post(
      '/wishlists/mine/items',
      data: request.toJson(),
    );
    return WishlistItemDto.fromJson(response.data);
  }

  @override
  Future<void> removeItem(int wishlistItemId) async {
    await apiClient.delete('/wishlists/mine/items/$wishlistItemId');
  }

  @override
  Future<void> clearWishlist() async {
    // Magento API does not have a clear all endpoint, so we would
    // have to get all items and remove them one by one.
    // This is a placeholder for that logic.
    final wishlist = await getWishlist();
    for (final item in wishlist.items) {
      await removeItem(item.id);
    }
  }
}
