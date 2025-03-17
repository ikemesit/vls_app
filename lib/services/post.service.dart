import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vls_app/models/post.model.dart';

class PostsService {
  final supabase = Supabase.instance.client;

  Future<List<Post>> getAllPosts() async {
    final response = await supabase
        .from('posts')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((data) => Post.fromJson(data))
        .toList();
  }

  Future<Post?> getPostById(String id) async {
    final response =
    await supabase.from('posts').select().eq('id', id).single();

    return Post.fromJson(response);
  }
}