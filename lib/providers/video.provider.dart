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

      // If no Supabase, use hardcoded data as fallback
      // if (_videos.isEmpty) {
      //   _videos = [
      //     Video(
      //       id: 'dQw4w9WgXcQ',
      //       title: 'Rick Astley - Never Gonna Give You Up',
      //       thumbnailUrl: 'https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg',
      //       createdAt: DateTime.now(),
      //     ),
      //     Video(
      //       id: '9bZkp7q19f0',
      //       title: 'PSY - GANGNAM STYLE',
      //       thumbnailUrl: 'https://img.youtube.com/vi/9bZkp7q19f0/0.jpg',
      //       createdAt: DateTime.now(),
      //     ),
      //     Video(
      //       id: 'JGwWNGJdvx8',
      //       title: 'Ed Sheeran - Shape of You',
      //       thumbnailUrl: 'https://img.youtube.com/vi/JGwWNGJdvx8/0.jpg',
      //       createdAt: DateTime.now(),
      //     ),
      //   ];
      // }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      // Log error or handle as needed
      print('Error fetching videos: $e');
    }
  }

  Future<void> refreshVideos() async {
    await fetchVideos(); // Method to refresh the list
  }
}
