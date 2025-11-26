import 'package:antoine_online_app/src/data/models/catalog/category.dart';
import 'package:antoine_online_app/src/data/models/catalog/product.dart';

abstract class CatalogRepository {
  Future<List<Category>> getCategories();
  Future<List<Product>> getProducts(int categoryId);
  Future<List<Product>> searchProducts(String query);
}
