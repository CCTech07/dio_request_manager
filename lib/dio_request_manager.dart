library;

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

enum RequestType { post, get, put, delete }

class DioRequestManager {
  final Dio dio = Dio();
  final String baseUrl;
  final Future<String?> Function()? getToken;

  DioRequestManager({required this.baseUrl, this.getToken}) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = _defaultHeaders();
  }

  Future<ApiResponse> request(
    String endpoint,
    dynamic body,
    RequestType requestType, {
    bool useToken = false,
  }) async {
    ApiResponse apiResponse = ApiResponse(
      message: 'No data',
      success: false,
      data: '0',
    );

    try {
      final String apiUrl = "$baseUrl$endpoint";
      log("Requesting: $apiUrl");

      Options options = Options(headers: await _getHeaders(useToken));

      Response response;
      switch (requestType) {
        case RequestType.post:
          response = await dio.post(apiUrl, data: body, options: options);
          break;
        case RequestType.get:
          response = await dio.get(
            apiUrl,
            queryParameters: body,
            options: options,
          );
          break;
        case RequestType.put:
          response = await dio.put(apiUrl, data: body, options: options);
          break;
        case RequestType.delete:
          response = await dio.delete(apiUrl, data: body, options: options);
          break;
      }

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioException(e);
    } on SocketException {
      return ApiResponse(
        message: "No Internet Connection",
        success: false,
        data: 0,
      );
    }
  }

  Map<String, String> _defaultHeaders() => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<Map<String, String>> _getHeaders(bool useToken) async {
    String? token = useToken ? await getToken?.call() : null;
    return {
      ..._defaultHeaders(),
      if (useToken && token != null) "Authorization": "Bearer $token",
      "Accept-Lang": "en",
    };
  }

  ApiResponse _handleResponse(Response response) {
    if (response.data is Map<String, dynamic>) {
      return ApiResponse(
        message: response.data['message'] ?? '',
        success: response.data['success'] ?? true,
        data: response.data['data'] ?? response.data,
      );
    } else {
      return ApiResponse(
        message: "Unexpected response format",
        success: false,
        data: response.data,
      );
    }
  }

  ApiResponse _handleDioException(DioException e) {
    if (e.response != null) {
      return ApiResponse(
        message: e.response?.data['message'] ?? "Error occurred",
        success: false,
        data: e.response?.statusCode ?? 0,
      );
    }
    return ApiResponse(message: "Unknown error", success: false, data: 0);
  }
}

class ApiResponse {
  String message;
  bool success;
  dynamic data;

  ApiResponse({
    required this.message,
    required this.success,
    required this.data,
  });
}
