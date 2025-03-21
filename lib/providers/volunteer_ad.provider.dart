import 'package:flutter/material.dart';
import 'package:vls_app/models/volunteer_user.model.dart';

import '../models/volunteer_ad.model.dart';
import '../services/volunteer_ad.service.dart';

class VolunteerAdProvider with ChangeNotifier {
  final VolunteerAdService _service = VolunteerAdService();

  List<VolunteerAd> _ads = [];
  VolunteerUser? _adVolunteer;
  bool _isLoading = false;

  List<VolunteerAd> get ads => _ads;

  VolunteerUser? get adVolunteer => _adVolunteer;

  bool get isLoading => _isLoading;

  VolunteerAdProvider() {
    fetchAds();
  }

  Future<void> fetchAds() async {
    _isLoading = true;
    notifyListeners();

    try {
      _ads = await _service.getAllVolunteerAds();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load ads: $e');
    }
  }

  Future<void> refreshAds() async {
    await fetchAds();
  }

  Future<void> fetchVolunteerById(int adId, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _adVolunteer = await _service.getVolunteerById(adId, userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load volunteer: $e');
    }
  }

  Future<void> confirmUserAsVolunteer(int adId, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.confirmUserAsVolunteer(adId, userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to confirm attendance: $e');
    }
  }
}
