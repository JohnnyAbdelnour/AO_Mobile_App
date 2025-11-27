import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/core/errors/failure.dart';
import 'package:antoine_online_app/features/store_locator/data/datasources/store_locator_remote_datasource.dart';
import 'package:antoine_online_app/features/store_locator/domain/entities/store_location.dart';
import 'package:antoine_online_app/features/store_locator/domain/repositories/store_locator_repository.dart';
import 'package:antoine_online_app/core/network/magento_api_exception.dart';
import 'package:dio/dio.dart';

class StoreLocatorRepositoryImpl implements StoreLocatorRepository {
  final StoreLocatorRemoteDataSource remoteDataSource;

  StoreLocatorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<StoreLocation>>> getStoreLocations() async {
    try {
      final storeLocationDtos = await remoteDataSource.getStoreLocations();
      return Right(storeLocationDtos.map((e) => e.toDomain()).toList());
    } on MagentoApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioError catch (e) {
      return Left(ServerFailure(e.message ?? 'A network error occurred.'));
    }
  }
}
