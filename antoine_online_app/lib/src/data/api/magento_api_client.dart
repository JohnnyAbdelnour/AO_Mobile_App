import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'magento_api_exception.dart';

class MagentoApiClient {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  final String _storeCode;

  factory MagentoApiClient(FlutterSecureStorage secureStorage) {
    final dio = Dio();
    final baseUrl = dotenv.env['MAGENTO_BASE_URL'] ?? 'https://www.antoineonline.com';
    final storeCode = dotenv.env['EN_STORE_CODE'] ?? 'intr/en';
    dio.options.baseUrl = '$baseUrl/rest';
    return MagentoApiClient._(dio, secureStorage, storeCode);
  }

  MagentoApiClient._(this._dio, this._secureStorage, this._storeCode) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add store code to path
          options.path = '/$_storeCode/V1${options.path}';

          // Add auth token
          final token = await _secureStorage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioError e, handler) {
          if (e.response?.data != null && e.response!.data is Map<String, dynamic>) {
            final message = e.response!.data['message'] ?? 'An unknown error occurred.';
            throw MagentoApiException(message: message, statusCode: e.response?.statusCode);
          }
          throw MagentoApiException(message: e.message ?? 'A network error occurred.', statusCode: e.response?.statusCode);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {data}) {
    return _dio.post(path, data: data);
  }
}
