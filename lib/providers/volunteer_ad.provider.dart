import 'package:flutter/material.dart';

import '../models/volunteer_ad.model.dart';
import '../services/volunteer_ad.service.dart';

class VolunteerAdProvider with ChangeNotifier {
  final VolunteerAdService _service = VolunteerAdService();
  List<VolunteerAd> _ads = [];
  bool _isLoading = false;

  List<VolunteerAd> get ads => _ads;

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
}
