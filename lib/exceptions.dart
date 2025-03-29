class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'ApiException: $message (Status Code: $statusCode)';
  }
}

class NetworkException extends ApiException {
  NetworkException({super.message = "No Internet Connection"});
}

class ServerException extends ApiException {
  ServerException({required super.message, super.statusCode});
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({String message = "Unauthorized Access"})
    : super(message: message, statusCode: 401);
}
