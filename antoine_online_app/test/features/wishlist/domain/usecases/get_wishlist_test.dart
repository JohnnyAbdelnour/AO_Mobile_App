import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:antoine_online_app/features/wishlist/domain/entities/wishlist.dart';
import 'package:antoine_online_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:antoine_online_app/features/wishlist/domain/usecases/get_wishlist.dart';

class MockWishlistRepository extends Mock implements WishlistRepository {}

void main() {
  late GetWishlist usecase;
  late MockWishlistRepository mockWishlistRepository;

  setUp(() {
    mockWishlistRepository = MockWishlistRepository();
    usecase = GetWishlist(mockWishlistRepository);
  });

  final tWishlist = Wishlist(id: 1, items: []);

  test(
    'should get wishlist from the repository',
    () async {
      // arrange
      when(mockWishlistRepository.getWishlist())
          .thenAnswer((_) async => Right(tWishlist));
      // act
      final result = await usecase();
      // assert
      expect(result, Right(tWishlist));
      verify(mockWishlistRepository.getWishlist());
      verifyNoMoreInteractions(mockWishlistRepository);
    },
  );
}
