import 'package:flutter/material.dart';
import 'package:vls_app/models/user_profile.model.dart';
import 'package:vls_app/services/user_profile.service.dart';

class UserProfileProvider with ChangeNotifier {
  final UserProfileService _service = UserProfileService();

  UserProfile? _profile;
  bool _isLoading = false;
  String? userId;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;

  UserProfileProvider() {
    // if (userId != null) {
    // _initProfile();
    // }
  }

  UserProfileProvider.update(this.userId, UserProfileProvider? previous) {
    if (userId != null) {
      _profile = previous?._profile;
      _initProfile();
    }
  }

  void _initProfile() {
    if (userId != null) {
      fetchUserProfile(userId as String);
    } else {
      _profile = null;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _profile = await _service.getUserProfile(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to fetch profile: $e');
    }
  }

  Future<void> createUserProfile(UserProfile profile) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.createUserProfile(profile);
      _profile = profile;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to create profile: $e');
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.updateUserProfile(profile);
      _profile = profile;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to update profile: $e');
    }
  }
}
