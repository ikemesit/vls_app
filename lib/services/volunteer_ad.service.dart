import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vls_app/models/volunteer_ad.model.dart';
import 'package:vls_app/models/volunteer_user.model.dart';

class VolunteerAdService {
  final _supabase = Supabase.instance.client;

  Future<List<VolunteerAd>> getAllVolunteerAds() async {
    final response = await _supabase
        .from('volunteer_ads')
        .select()
        .order('created_at');

    return (response as List).map((e) => VolunteerAd.fromJson(e)).toList();
  }

  Future<VolunteerAd> getVolunteerAdById(int id) async {
    final response =
        await _supabase.from('volunteer_ads').select().eq('id', id).single();

    return VolunteerAd.fromJson(response);
  }

  Future<VolunteerUser?> getVolunteerById(int adId, String userId) async {
    final response =
        await _supabase
            .from('volunteer_users')
            .select()
            .eq('ad_id', adId)
            .eq('user_id', userId)
            .maybeSingle();

    if (response != null) {
      return VolunteerUser.fromJson(response);
    } else {
      return null;
    }
  }

  Future<void> confirmUserAsVolunteer(int adId, String userId) async {
    try {
      final response =
          await _supabase
              .from('volunteer_users')
              .select()
              .eq('ad_id', adId)
              .eq('user_id', userId)
              .maybeSingle();

      if (response != null) {
        throw Exception('You are already a volunteer!');
      }

      await _supabase.from('volunteer_users').insert({
        'ad_id': adId,
        'user_id': userId,
      });
    } catch (e) {
      throw Exception('Failed to register as volunteer: $e');
    }
  }
}
