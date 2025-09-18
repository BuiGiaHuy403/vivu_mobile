class ApiResponse<T> {
  final String status;
  final int code;
  final String message;
  final String traceId;
  final T? data;

  ApiResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.traceId,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json)? fromData,
      ) {
    return ApiResponse<T>(
      status: json['status'] ?? '',
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      traceId: json['trace_id'] ?? '',
      data: (json['data'] != null && fromData != null)
          ? fromData(json['data'])
          : null,    );
  }
}
