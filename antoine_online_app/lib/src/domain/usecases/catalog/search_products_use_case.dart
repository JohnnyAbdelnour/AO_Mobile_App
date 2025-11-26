import 'package:antoine_online_app/src/domain/repositories/catalog_repository.dart';
import 'package:antoine_online_app/src/data/models/catalog/product.dart';

class SearchProductsUseCase {
  final CatalogRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<List<Product>> call(String query) {
    return _repository.searchProducts(query);
  }
}
