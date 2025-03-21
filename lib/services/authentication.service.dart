import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'display_name': displayName},
      );
    } on AuthException catch (e) {
      print(e);
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> updatePassword({required String newPassword}) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
    } catch (e) {
      throw Exception('Password update failed: $e');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'https://vls-party.web.app/reset-user-password',
      );
    } on AuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  Future<void> updateUser({
    String? email,
    String? password,
    String? displayName,
  }) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(
          email: email,
          password: password,
          data: {'display_name': displayName},
        ),
      );
    } catch (e) {
      throw Exception('User update failed: $e');
    }
  }

  // Get current session
  Session? getCurrentSession() => supabase.auth.currentSession;

  // Listen to auth state changes
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
}
