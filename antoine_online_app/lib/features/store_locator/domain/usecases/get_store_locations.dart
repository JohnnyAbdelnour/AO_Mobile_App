import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/store_locator/domain/entities/store_location.dart';
import 'package:antoine_online_app/features/store_locator/domain/repositories/store_locator_repository.dart';

class GetStoreLocations {
  final StoreLocatorRepository repository;

  GetStoreLocations(this.repository);

  Future<Either<Failure, List<StoreLocation>>> call() async {
    return await repository.getStoreLocations();
  }
}
