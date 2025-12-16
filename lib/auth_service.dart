import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> isLoggedIn() async {
    return _supabase.auth.currentUser != null;
  }

  Future<String?> getCurrentUsername() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    return user.userMetadata?['username'];
  }

  Future<String?> getCurrentUserId() async {
    return _supabase.auth.currentUser?.id;
  }

  Future<AuthResponse> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
    return response;
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  Future<bool> hasAccount() async {
    return _supabase.auth.currentUser != null;
  }
}