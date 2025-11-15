import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool(_isLoggedInKey);

    if (loggedIn == null) {return false;}return loggedIn;
  }
  Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }
  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_isLoggedInKey, true);
    return true;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final storedEmail = prefs.getString(_emailKey);
    final storedPassword = prefs.getString(_passwordKey);

    if (storedEmail == email && storedPassword == password) {
      await prefs.setBool(_isLoggedInKey, true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  Future<bool> hasAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_emailKey);

    if (email == null) {
      return false;
    }
    return true;
  }
}