import 'package:antoine_online_app/src/domain/repositories/auth_repository.dart';
import 'package:antoine_online_app/src/data/models/auth/login_request.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<void> call(LoginRequest request) {
    return _repository.login(request);
  }
}
