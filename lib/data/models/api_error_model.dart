class ApiError {
  ApiError({
    this.statusCode,
    this.success,
    this.message,
  });

  final int? statusCode;
  final bool? success;
  final String? message;

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        statusCode: json['status_code'],
        success: json['success'],
        message: json['status_message'],
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'success': success,
        'status_message': message,
      };
}
