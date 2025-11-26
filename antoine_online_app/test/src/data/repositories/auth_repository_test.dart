import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:antoine_online_app/src/data/api/magento_api_client.dart';
import 'package:antoine_online_app/src/data/repositories/auth/auth_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:antoine_online_app/src/data/models/auth/login_request.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([MagentoApiClient, FlutterSecureStorage])
void main() {
  late AuthRepositoryImpl authRepository;
  late MockMagentoApiClient mockApiClient;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockApiClient = MockMagentoApiClient();
    mockSecureStorage = MockFlutterSecureStorage();
    authRepository = AuthRepositoryImpl(mockApiClient, mockSecureStorage);
  });

  group('AuthRepository', () {
    test('login success stores token', () async {
      final loginRequest = LoginRequest(username: 'test@test.com', password: 'password');
      final response = Response(data: 'test_token', statusCode: 200, requestOptions: RequestOptions(path: ''));

      when(mockApiClient.post(any, data: anyNamed('data'))).thenAnswer((_) async => response);

      await authRepository.login(loginRequest);

      verify(mockSecureStorage.write(key: 'auth_token', value: 'test_token')).called(1);
    });

    test('isLoggedIn returns true when token exists', () async {
      when(mockSecureStorage.read(key: 'auth_token')).thenAnswer((_) async => 'test_token');

      final result = await authRepository.isLoggedIn();

      expect(result, true);
    });

    test('isLoggedIn returns false when token does not exist', () async {
      when(mockSecureStorage.read(key: 'auth_token')).thenAnswer((_) async => null);

      final result = await authRepository.isLoggedIn();

      expect(result, false);
    });

    test('logout deletes token', () async {
      await authRepository.logout();

      verify(mockSecureStorage.delete(key: 'auth_token')).called(1);
    });
  });
}
