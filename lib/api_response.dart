class ApiResponse {
  final String message;
  final bool success;
  final dynamic data;

  ApiResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'success': success, 'data': data};
  }
}
