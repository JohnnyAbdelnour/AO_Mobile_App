import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/features/store_locator/domain/entities/store_location.dart';
import 'package:antoine_online_app/features/store_locator/domain/usecases/get_store_locations.dart';
import 'package:antoine_online_app/features/store_locator/data/repositories/store_locator_repository_impl.dart';
import 'package:antoine_online_app/features/store_locator/data/datasources/store_locator_remote_datasource.dart';
import 'package:antoine_online_app/src/presentation/providers/auth/auth_providers.dart';

final storeLocatorRemoteDataSourceProvider = Provider<StoreLocatorRemoteDataSource>((ref) {
  return StoreLocatorRemoteDataSourceImpl(apiClient: ref.watch(apiClientProvider));
});

final storeLocatorRepositoryProvider = Provider<StoreLocatorRepositoryImpl>((ref) {
  return StoreLocatorRepositoryImpl(remoteDataSource: ref.watch(storeLocatorRemoteDataSourceProvider));
});

final getStoreLocationsProvider = Provider<GetStoreLocations>((ref) {
  return GetStoreLocations(ref.watch(storeLocatorRepositoryProvider));
});

final storeLocatorProvider = StateNotifierProvider<StoreLocatorNotifier, AsyncValue<List<StoreLocation>>>((ref) {
  return StoreLocatorNotifier(
    ref.watch(getStoreLocationsProvider),
  );
});

class StoreLocatorNotifier extends StateNotifier<AsyncValue<List<StoreLocation>>> {
  final GetStoreLocations _getStoreLocations;

  StoreLocatorNotifier(
    this._getStoreLocations,
  ) : super(const AsyncValue.loading()) {
    loadStoreLocations();
  }

  Future<void> loadStoreLocations() async {
    final result = await _getStoreLocations();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (storeLocations) => state = AsyncValue.data(storeLocations),
    );
  }
}
