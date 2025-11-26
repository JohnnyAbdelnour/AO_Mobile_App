import 'package:antoine_online_app/src/data/models/auth/login_request.dart';
import 'package:antoine_online_app/src/data/models/auth/registration_request.dart';

abstract class AuthRepository {
  Future<void> login(LoginRequest request);
  Future<void> register(RegistrationRequest request);
  Future<void> logout();
  Future<bool> isLoggedIn();
}
