import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vls_app/models/video.model.dart';

class VideoProvider with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Video> _videos = [];
  bool _isLoading = false;

  List<Video> get videos => _videos;
  bool get isLoading => _isLoading;

  VideoProvider() {
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await supabase.from('videos').select();
      _videos = (response as List).map((json) => Video.fromJson(json)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error fetching videos: $e ');
    }
  }

  Future<void> refreshVideos() async {
    await fetchVideos(); // Method to refresh the list
  }
}
