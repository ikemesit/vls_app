import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vls_app/models/video.model.dart';
import 'package:vls_app/pages/videos/video_player_page.dart';
import 'package:vls_app/utils/constants/colors.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: TColors.white,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: _launchURL,
        // () => Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) => VideoPlayerPage(video: video)),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
              child: CachedNetworkImage(
                imageUrl: video.thumbnailUrl,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                video.title,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.share, size: 20.0),
                    onPressed: () => _shareVideo(context, video),
                    tooltip: 'Share',
                  ),
                  IconButton(
                    icon: Icon(Icons.link, size: 20.0),
                    onPressed: () => _copyLink(context, video),
                    tooltip: 'Copy Link',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareVideo(BuildContext context, Video video) {
    // final url = 'https://www.youtube.com/watch?v=${video.id}';
    Share.share('Check out this video: ${video.title}\n$video.url');
  }

  void _copyLink(BuildContext context, Video video) {
    // final url = 'https://www.youtube.com/watch?v=${video.id}';
    Share.share(video.url);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Link copied to clipboard')));
  }

  void _launchURL() async {
    final Uri url = Uri.parse(video.url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
