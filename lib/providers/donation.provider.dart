import 'package:flutter/material.dart';
import 'package:vls_app/models/donation.model.dart';
import 'package:vls_app/services/donation.service.dart';

class DonationProvider with ChangeNotifier {
  final DonationService _service = DonationService();
  List<Donation> _donations = [];
  bool _isLoading = false;
  final String? userId;

  List<Donation> get donations => _donations;
  bool get isLoading => _isLoading;

  DonationProvider(this.userId) {
    _initDonations();
  }

  DonationProvider.update(this.userId, DonationProvider? previous) {
    _donations = previous?._donations ?? [];
    _initDonations();
  }

  void _initDonations() {
    if (userId != null) {
      fetchDonations();
    } else {
      _donations = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDonations() async {
    if (userId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _donations = await _service.getUserDonations(userId!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load donations: $e');
    }
  }

  Future<void> makeDonation(double amount, String? description) async {
    if (userId == null) throw Exception('User must be logged in to donate');

    _isLoading = true;
    notifyListeners();

    try {
      final donation = Donation(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount,
        date: DateTime.now(),
        userId: userId!,
        description: description,
      );
      await _service.createDonation(donation);
      _donations.insert(0, donation); // Add to top of list
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to process donation: $e');
    }
  }
}
