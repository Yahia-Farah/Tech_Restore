import 'dart:convert';
import 'package:dio/dio.dart';
import 'failure.dart';

class ApiErrorHandler {
  static String extractMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      return
          data['message'] ??
          ServerFailure.fromDio(e).errorMessage;
    }

    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map<String, dynamic>) {
          return
              decoded['message'] ??
              ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }

    return ServerFailure.fromDio(e).errorMessage;
  }
}
