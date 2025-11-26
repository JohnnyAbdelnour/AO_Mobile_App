import 'package:antoine_online_app/src/domain/repositories/auth_repository.dart';

class IsLoggedInUseCase {
  final AuthRepository _repository;

  IsLoggedInUseCase(this._repository);

  Future<bool> call() {
    return _repository.isLoggedIn();
  }
}
