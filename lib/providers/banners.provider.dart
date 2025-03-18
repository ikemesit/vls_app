// Events Provider
import 'package:flutter/material.dart';
import 'package:vls_app/services/banner.service.dart';

class BannerProvider with ChangeNotifier {
  final BannerService _service = BannerService();
  List<String> _banners = [];

  bool _isLoading = false;

  List<String> get banners => _banners;

  bool get isLoading => _isLoading;

  BannerProvider() {
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    _isLoading = true;
    notifyListeners();

    try {
      _banners = await _service.fetchAllBanners();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load banners: $e');
    }
  }
}
