import 'package:flutter/material.dart';
import 'package:vls_app/models/user.model.dart';
import 'package:vls_app/services/authentication.service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  AppUser? _user;
  bool _isLoading = false;

  AppUser? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _initAuthState();
  }

  void _initAuthState() {
    // Check initial session
    final session = _authService.getCurrentSession();
    if (session != null) {
      _user = AppUser.fromSession(session.user);
    }

    // Listen for auth state changes
    _authService.authStateChanges.listen((authState) {
      final session = authState.session;
      _user = session != null ? AppUser.fromSession(session.user) : null;
      notifyListeners();
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signIn(email: email, password: password);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signOut();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  updatePassword({required String newPassword}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.updatePassword(newPassword: newPassword);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.resetPassword(email: email);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateUser({
    String? email,
    String? password,
    String? displayName,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.updateUser(
        email: email,
        password: password,
        displayName: displayName,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
