import '../../../../core/contants/secure_storage.dart';
import '../../logout/viewmodel/app_navigator.dart';

class AuthService {
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String rememberMeKey = 'remember_me';
  static const String userIdKey = 'user_id';
  static const String roleKey = 'role';

  static Future<void> saveAuthToken(String token) async {
    await SecureStorage.write(key: tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await SecureStorage.read(tokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    await SecureStorage.write(key: refreshTokenKey, value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await SecureStorage.read(refreshTokenKey);
  }

  static Future<void> saveRole(String role) async {
    await SecureStorage.write(key: roleKey, value: role);
  }

  static Future<String?> getRole() async {
    return await SecureStorage.read(roleKey);
  }

  static Future<void> saveUserId(String userId) async {
    await SecureStorage.write(key: userIdKey, value: userId);
  }

  static Future<String?> getUserId() async {
    return await SecureStorage.read(userIdKey);
  }

  static Future<void> saveRememberMe(bool rememberMe) async {
    await SecureStorage.write(key: rememberMeKey, value: "$rememberMe");
  }

  static Future<bool> getRememberMe() async {
    final value = await SecureStorage.read(rememberMeKey);
    if (value == null) return false;
    return value == "true";
  }

  static Future<bool> isLoggedIn() async {
    final token = await SecureStorage.read(tokenKey);
    return token != null && token.isNotEmpty;
  }

  static Future<bool> isUserAuthenticated() async {
    final loggedIn = await isLoggedIn();
    final remembered = await getRememberMe();
    return loggedIn && remembered;
  }

  static Future<void> logout() async {
    await SecureStorage.delete(tokenKey);
    await SecureStorage.delete(refreshTokenKey);
    await SecureStorage.delete(rememberMeKey);
    await SecureStorage.delete(userIdKey);
    AppNavigator.logoutAndNavigate();
  }
}
