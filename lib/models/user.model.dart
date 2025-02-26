import 'package:supabase_flutter/supabase_flutter.dart';

class AppUser {
  final String id;
  final String? email;
  final String? displayName;

  AppUser({required this.id, this.email, this.displayName});

  factory AppUser.fromSession(User user) {
    return AppUser(
      id: user.id,
      email: user.email,
      displayName: user.userMetadata?['display_name'],
    );
  }
}
