import 'package:antoine_online_app/src/domain/repositories/auth_repository.dart';
import 'package:antoine_online_app/src/data/models/auth/registration_request.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<void> call(RegistrationRequest request) {
    return _repository.register(request);
  }
}
