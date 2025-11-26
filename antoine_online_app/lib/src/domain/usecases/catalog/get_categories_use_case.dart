import 'package:antoine_online_app/src/domain/repositories/catalog_repository.dart';
import 'package:antoine_online_app/src/data/models/catalog/category.dart';

class GetCategoriesUseCase {
  final CatalogRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<Category>> call() {
    return _repository.getCategories();
  }
}
