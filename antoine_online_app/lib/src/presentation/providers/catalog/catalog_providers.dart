import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antoine_online_app/src/data/repositories/catalog/catalog_repository_impl.dart';
import 'package:antoine_online_app/src/domain/repositories/catalog_repository.dart';
import 'package:antoine_online_app/src/domain/usecases/catalog/get_categories_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/catalog/get_products_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/catalog/search_products_use_case.dart';
import 'package:antoine_online_app/src/presentation/providers/auth/auth_providers.dart';
import 'package:antoine_online_app/src/data/models/catalog/category.dart';
import 'package:antoine_online_app/src/data/models/catalog/product.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) => CatalogRepositoryImpl(ref.read(apiClientProvider)));

final getCategoriesUseCaseProvider = Provider((ref) => GetCategoriesUseCase(ref.read(catalogRepositoryProvider)));
final getProductsUseCaseProvider = Provider((ref) => GetProductsUseCase(ref.read(catalogRepositoryProvider)));
final searchProductsUseCaseProvider = Provider((ref) => SearchProductsUseCase(ref.read(catalogRepositoryProvider)));

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  return ref.read(getCategoriesUseCaseProvider).call();
});

final productsProvider = FutureProvider.family<List<Product>, int>((ref, categoryId) async {
  return ref.read(getProductsUseCaseProvider).call(categoryId);
});

final searchProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchProvider);
  if (query.isEmpty) {
    return [];
  }
  return ref.read(searchProductsUseCaseProvider).call(query);
});
