import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:antoine_online_app/src/data/api/magento_api_client.dart';
import 'package:antoine_online_app/src/data/repositories/auth/auth_repository_impl.dart';
import 'package:antoine_online_app/src/domain/repositories/auth_repository.dart';
import 'package:antoine_online_app/src/domain/usecases/auth/is_logged_in_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/auth/login_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/auth/logout_use_case.dart';
import 'package:antoine_online_app/src/domain/usecases/auth/register_use_case.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

final apiClientProvider = Provider((ref) => MagentoApiClient(ref.read(secureStorageProvider)));

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl(
      ref.read(apiClientProvider),
      ref.read(secureStorageProvider),
    ));

final isLoggedInUseCaseProvider = Provider((ref) => IsLoggedInUseCase(ref.read(authRepositoryProvider)));
final loginUseCaseProvider = Provider((ref) => LoginUseCase(ref.read(authRepositoryProvider)));
final logoutUseCaseProvider = Provider((ref) => LogoutUseCase(ref.read(authRepositoryProvider)));
final registerUseCaseProvider = Provider((ref) => RegisterUseCase(ref.read(authRepositoryProvider)));

final authStateProvider = StateNotifierProvider<AuthState, bool>((ref) {
  return AuthState(ref.read(isLoggedInUseCaseProvider));
});

class AuthState extends StateNotifier<bool> {
  final IsLoggedInUseCase _isLoggedInUseCase;

  AuthState(this._isLoggedInUseCase) : super(false) {
    _isLoggedInUseCase().then((value) => state = value);
  }

  void login() => state = true;

  void logout() => state = false;
}
