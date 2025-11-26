class MagentoApiException implements Exception {
  final String message;
  final int? statusCode;

  MagentoApiException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'MagentoApiException{message: $message, statusCode: $statusCode}';
  }
}
