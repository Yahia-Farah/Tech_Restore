import '../../../../core/contants/secure_storage.dart';

class AuthService {
  static const String tokenKey = 'auth_token';
  static const String rememberMeKey = 'remember_me';
  static const String userIdKey = 'user_id';
  static const String roleKey = 'role';

  static Future<void> saveAuthToken(String token) async {
    await SecureStorage.write(key: tokenKey, value: token);
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

  static Future<void> saveRememberMe(bool rememberMe) async {
    await SecureStorage.write(key: rememberMeKey, value: "$rememberMe");
  }

  static Future<bool> isUserAuthenticated() async {
    final loggedIn = await AuthService.isLoggedIn();
    final remembered = await AuthService.getRememberMe();
    return loggedIn && remembered;
  }

  static Future<bool> isLoggedIn() async {
    final token = await SecureStorage.read(tokenKey);
    return token != null && token.isNotEmpty;
  }

  static Future<bool> getRememberMe() async {
    final value = await SecureStorage.read(rememberMeKey);
    if (value == null) return false;
    return value == "true";
  }

  static Future<String?> getToken() async {
    return await SecureStorage.read(tokenKey);
  }

  static Future<String?> getUserId() async {
    return await SecureStorage.read(userIdKey);
  }

  static Future<void> logout() async {
    await SecureStorage.delete(tokenKey);
    await SecureStorage.delete(rememberMeKey);
    await SecureStorage.delete(userIdKey);
  }
}
