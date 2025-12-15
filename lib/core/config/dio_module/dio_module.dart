import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../features/auth/domain/services/auth_services.dart';
import '../../api/api_constants/api_constants.dart';

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

            if (requestOptions.extra['retry'] == true) {
              await AuthService.logout();
              return handler.reject(error);
            }

            try {
              final newToken = await _refreshToken();

              if (newToken != null) {
                await AuthService.saveAuthToken(newToken);

                requestOptions.headers['Authorization'] = 'Bearer $newToken';
                requestOptions.extra['retry'] = true;

                final response = await dio.fetch(requestOptions);
                return handler.resolve(response);
              }
            } catch (_) {
              await AuthService.logout();
            }
          }

          handler.reject(error);
        },
      ),
    );


    return dio;
  }

  @Named('baseurl')
  String get baseUrl => ApiConstant.baseUrl;
}

Future<String?> _refreshToken() async {
  final refreshToken = await AuthService.getRefreshToken();

  if (refreshToken == null) return null;

  try {
    final response = await Dio().post(
      'http://localhost:8080/api/auth/refresh-token',
      data: {
        "refreshToken": refreshToken,
      },
    );

    return response.data["accessToken"];
  } catch (_) {
    return null;
  }
}

