import 'package:supabase_flutter/supabase_flutter.dart';

class BannerService {
  final supabase = Supabase.instance.client;

  Future<List<String>> fetchAllBanners() async {
    try {
      List<String> bannerUrls = [];
      final files = await supabase.storage.from('images').list(path: 'banners');

      for (var i = 0; i < files.length; i++) {
        final url = supabase.storage
            .from('images')
            .getPublicUrl(
              'banners/${files[i].name}',
              // transform: TransformOptions(width: 500, height: 300),
            );

        bannerUrls.add(url);
      }

      return Future.value(bannerUrls);
    } catch (e) {
      throw Exception('Error retrieving banners: $e');
    }
  }
}
