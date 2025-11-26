import 'package:antoine_online_app/src/domain/repositories/catalog_repository.dart';
import 'package:antoine_online_app/src/data/api/magento_api_client.dart';
import 'package:antoine_online_app/src/data/models/catalog/category.dart';
import 'package:antoine_online_app/src/data/models/catalog/product.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  final MagentoApiClient _apiClient;

  CatalogRepositoryImpl(this._apiClient);

  @override
  Future<List<Category>> getCategories() async {
    final response = await _apiClient.get('/categories');
    final data = response.data['children_data'] as List;
    return data.map((category) => Category.fromJson(category)).toList();
  }

  @override
  Future<List<Product>> getProducts(int categoryId) async {
    final response = await _apiClient.get(
      '/products',
      queryParameters: {
        'searchCriteria[filter_groups][0][filters][0][field]': 'category_id',
        'searchCriteria[filter_groups][0][filters][0][value]': categoryId,
      },
    );
    final data = response.data['items'] as List;
    return data.map((product) => Product.fromJson(product)).toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final response = await _apiClient.get(
      '/products',
      queryParameters: {
        'searchCriteria[filter_groups][0][filters][0][field]': 'name',
        'searchCriteria[filter_groups][0][filters][0][value]': '%$query%',
        'searchCriteria[filter_groups][0][filters][0][condition_type]': 'like',
      },
    );
    final data = response.data['items'] as List;
    return data.map((product) => Product.fromJson(product)).toList();
  }
}
