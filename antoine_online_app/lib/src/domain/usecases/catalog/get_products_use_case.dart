import 'package:antoine_online_app/src/domain/repositories/catalog_repository.dart';
import 'package:antoine_online_app/src/data/models/catalog/product.dart';

class GetProductsUseCase {
  final CatalogRepository _repository;

  GetProductsUseCase(this._repository);

  Future<List<Product>> call(int categoryId) {
    return _repository.getProducts(categoryId);
  }
}
