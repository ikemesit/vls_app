import 'package:flutter/material.dart';

import '../models/post.model.dart';
import '../services/post.service.dart';

class PostsProvider with ChangeNotifier {
  final PostsService _service = PostsService();
  List<Post> _posts = [];
  Post? _selectedPost;
  bool _isLoading = false;

  List<Post> get posts => _posts;

  Post? get selectedPost => _selectedPost;

  bool get isLoading => _isLoading;

  PostsProvider() {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await _service.getAllPosts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<void> fetchPostById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedPost = await _service.getPostById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load event: $e');
    }
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }
}
