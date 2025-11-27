// lib/features/store_locator/domain/repositories/store_locator_repository.dart
import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/store_locator/domain/entities/store_location.dart';

abstract class StoreLocatorRepository {
  /// Get all store locations.
  Future<Either<Failure, List<StoreLocation>>> getStoreLocations();
}
