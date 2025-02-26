import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vls_app/models/donation.model.dart';

class DonationService {
  final supabase = Supabase.instance.client;

  Future<void> createDonation(Donation donation) async {
    try {
      await supabase.from('donations').insert(donation.toJson());
    } catch (e) {
      throw Exception('Failed to process donation: $e');
    }
  }

  Future<List<Donation>> getUserDonations(String userId) async {
    try {
      final response = await supabase
          .from('donations')
          .select()
          .eq('userId', userId)
          .order('date', ascending: false);
      return (response as List).map((json) => Donation.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch donations: $e');
    }
  }
}
