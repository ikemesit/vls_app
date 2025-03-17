import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vls_app/models/volunteer_ad.model.dart';

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
}
