import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../features/auth/domain/services/auth_services.dart';
import '../../api/api_constants/api_constants.dart';

// Global lock to prevent multiple simultaneous token refresh attempts
bool _isRefreshing = false;
List<Completer<String?>> _refreshCompleters = [];

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(@Named('baseurl') String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresAuth = options.extra['auth'] == true;

          if (requiresAuth) {
            final token = await AuthService.getToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final requestOptions = error.requestOptions;
            final isLogoutRequest = requestOptions.path.contains('auth/logout');

            // Handle logout request - always succeed
            if (isLogoutRequest) {
              await AuthService.logout();
              return handler.resolve(
                Response(
                  requestOptions: requestOptions,
                  statusCode: 200,
                  data: 'Logout successful',
                ),
              );
            }

            // If this is already a retry attempt, logout and reject
            if (requestOptions.extra['retry'] == true) {
              await AuthService.logout();
              return handler.reject(error);
            }

            // Try to refresh token with lock mechanism
            try {
              final newToken = await _refreshTokenWithLock();

              if (newToken != null && newToken.isNotEmpty) {
                // Save new token
                await AuthService.saveAuthToken(newToken);

                // Update request with new token and mark as retry
                requestOptions.headers['Authorization'] = 'Bearer $newToken';
                requestOptions.extra['retry'] = true;

                // Retry the original request
                try {
                  final response = await dio.fetch(requestOptions);
                  return handler.resolve(response);
                } catch (retryError) {
                  // If retry fails, logout and reject
                  await AuthService.logout();
                  if (retryError is DioException) {
                    return handler.reject(retryError);
                  } else {
                    return handler.reject(DioException(
                      requestOptions: requestOptions,
                      error: retryError,
                    ));
                  }
                }
              } else {
                // Refresh token failed or returned null/empty, logout
                await AuthService.logout();
                return handler.reject(error);
              }
            } catch (refreshError) {
              // Refresh token request failed, logout
              await AuthService.logout();
              return handler.reject(error);
            }
          }

          // For non-401 errors, just pass through
          handler.reject(error);
        },
      ),
    );

    return dio;
  }

  @Named('baseurl')
  String get baseUrl => ApiConstant.baseUrl;
}

Future<String?> _refreshTokenWithLock() async {
  // If already refreshing, wait for the result
  if (_isRefreshing) {
    final completer = Completer<String?>();
    _refreshCompleters.add(completer);
    return completer.future;
  }

  // Start refreshing
  _isRefreshing = true;
  
  try {
    final newToken = await _refreshToken();
    
    // Notify all waiting requests
    for (final completer in _refreshCompleters) {
      completer.complete(newToken);
    }
    _refreshCompleters.clear();
    
    return newToken;
  } catch (e) {
    // Notify all waiting requests of failure
    for (final completer in _refreshCompleters) {
      completer.complete(null);
    }
    _refreshCompleters.clear();
    
    rethrow;
  } finally {
    _isRefreshing = false;
  }
}

Future<String?> _refreshToken() async {
  try {
    final refreshToken = await AuthService.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    final response = await Dio().post(
      'http://localhost:8080/api/auth/refresh-token',
      data: {"refreshToken": refreshToken},
      options: Options(
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      final accessToken = response.data["accessToken"];
      if (accessToken != null && accessToken.toString().isNotEmpty) {
        return accessToken.toString();
      }
    }

    return null;
  } catch (e) {
    // Log the error for debugging (in production, use proper logging)
    if (kDebugMode) {
      print('Token refresh failed: $e');
    }
    return null;
  }
}
