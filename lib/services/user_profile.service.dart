import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vls_app/models/user_profile.model.dart';

class UserProfileService {
  final supabase = Supabase.instance.client;

  Future<void> createUserProfile(UserProfile profile) async {
    try {
      await supabase
          .from('user_profiles')
          .insert(
            profile.toJson(
              profile.firstname,
              profile.middlename,
              profile.lastname,
              profile.dob,
              profile.gender,
              profile.email,
              profile.phone,
              profile.address,
              profile.city,
              profile.state,
              profile.nin,
              profile.citizenshipStatus,
              profile.userId,
            ),
          );
    } catch (e) {
      throw Exception('Failed to create profile: $e');
    }
  }

  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final response =
          await supabase
              .from('user_profiles')
              .select()
              .eq('user_id', userId)
              .single();
      return UserProfile.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUserProfile(UserProfile profile) async {
    try {
      await supabase
          .from('user_profiles')
          .update(
            profile.toJson(
              profile.firstname,
              profile.middlename,
              profile.lastname,
              profile.dob,
              profile.gender,
              profile.email,
              profile.phone,
              profile.address,
              profile.city,
              profile.state,
              profile.nin,
              profile.citizenshipStatus,
              profile.userId,
            ),
          )
          .eq('user_id', profile.userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
