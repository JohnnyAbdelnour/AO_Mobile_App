import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/features/store_locator/domain/entities/store_location.dart';
import 'package:antoine_online_app/features/store_locator/domain/repositories/store_locator_repository.dart';
import 'package:antoine_online_app/features/store_locator/domain/usecases/get_store_locations.dart';

class MockStoreLocatorRepository extends Mock implements StoreLocatorRepository {}

void main() {
  late GetStoreLocations usecase;
  late MockStoreLocatorRepository mockStoreLocatorRepository;

  setUp(() {
    mockStoreLocatorRepository = MockStoreLocatorRepository();
    usecase = GetStoreLocations(mockStoreLocatorRepository);
  });

  final tStoreLocations = [
    StoreLocation(
      id: 1,
      name: 'Achrafieh',
      address: 'Some street, Beirut, Lebanon',
      latitude: 33.8938,
      longitude: 35.5018,
    ),
  ];

  test(
    'should get store locations from the repository',
    () async {
      // arrange
      when(mockStoreLocatorRepository.getStoreLocations())
          .thenAnswer((_) async => Right(tStoreLocations));
      // act
      final result = await usecase();
      // assert
      expect(result, Right(tStoreLocations));
      verify(mockStoreLocatorRepository.getStoreLocations());
      verifyNoMoreInteractions(mockStoreLocatorRepository);
    },
  );
}
