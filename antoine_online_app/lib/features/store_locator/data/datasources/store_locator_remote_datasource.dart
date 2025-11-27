import 'package:antoine_online_app/core/network/magento_api_client.dart';
import 'package:antoine_online_app/features/store_locator/data/models/store_location_dto.dart';

abstract class StoreLocatorRemoteDataSource {
  Future<List<StoreLocationDto>> getStoreLocations();
}

class StoreLocatorRemoteDataSourceImpl implements StoreLocatorRemoteDataSource {
  final MagentoApiClient apiClient;

  StoreLocatorRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<StoreLocationDto>> getStoreLocations() async {
    // final response = await apiClient.get('/store-locations');
    // return (response.data as List).map((e) => StoreLocationDto.fromJson(e)).toList();

    // Returning mock data for now
    await Future.delayed(const Duration(seconds: 1));
    return [
      {
        "id": 1,
        "name": "Achrafieh",
        "address": "Some street, Beirut, Lebanon",
        "phone": "+961 1 234 567",
        "email": "achrafieh@antoineonline.com",
        "latitude": 33.8938,
        "longitude": 35.5018,
        "opening_hours": {
          "mon_fri": "9:00–20:00",
          "sat": "9:00–21:00",
          "sun": "Closed"
        }
      }
    ].map((e) => StoreLocationDto.fromJson(e)).toList();
  }
}
