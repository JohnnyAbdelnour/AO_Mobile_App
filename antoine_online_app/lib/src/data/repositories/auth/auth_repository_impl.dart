import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:antoine_online_app/src/domain/repositories/auth_repository.dart';
import 'package:antoine_online_app/src/data/api/magento_api_client.dart';
import 'package:antoine_online_app/src/data/models/auth/login_request.dart';
import 'package:antoine_online_app/src/data/models/auth/registration_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final MagentoApiClient _apiClient;
  final FlutterSecureStorage _secureStorage;
  static const _authTokenKey = 'auth_token';

  AuthRepositoryImpl(this._apiClient, this._secureStorage);

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: _authTokenKey);
    return token != null;
  }

  @override
  Future<void> login(LoginRequest request) async {
    final response = await _apiClient.post(
      '/integration/customer/token',
      data: request.toJson(),
    );
    final token = response.data;
    if (token is String) {
      await _secureStorage.write(key: _authTokenKey, value: token);
    } else {
      throw Exception('Failed to get token from login response.');
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(key: _authTokenKey);
  }

  @override
  Future<void> register(RegistrationRequest request) async {
    await _apiClient.post(
      '/customers',
      data: request.toJson(),
    );
  }
}
