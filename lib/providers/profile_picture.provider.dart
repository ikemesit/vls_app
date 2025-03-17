import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePictureProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  String? _profilePictureUrl;
  bool _isUploading = false;

  String? get profilePictureUrl => _profilePictureUrl;
  bool get isUploading => _isUploading;

  ProfilePictureProvider(String? userId) {
    if (userId != null) {
      fetchProfilePicture(userId);
    }
  }

  ProfilePictureProvider.update(String? userId) {
    if (userId != null) {
      fetchProfilePicture(userId);
    }
  }

  void fetchProfilePicture(String userId) {
    try {
      final response = supabase.storage
          .from('profile-pictures')
          .getPublicUrl('$userId/profile.jpg');

      _profilePictureUrl = response;
      notifyListeners();
    } catch (e) {
      print('Error fetching profile picture: $e');
    }
  }

  Future<void> uploadProfilePicture(File image, String userId) async {
    _isUploading = true;
    notifyListeners();

    try {
      final fileName = '$userId/profile.jpg';
      await supabase.storage
          .from('profile-pictures')
          .upload(fileName, image, fileOptions: FileOptions(upsert: true));

      final publicUrl = supabase.storage
          .from('profile-pictures')
          .getPublicUrl(fileName);
      _profilePictureUrl = publicUrl;
      _isUploading = false;
      notifyListeners();
    } catch (e) {
      _isUploading = false;
      notifyListeners();
      throw Exception('Failed to upload profile picture: $e');
    }
  }
}
