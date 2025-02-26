import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/models/video.model.dart';
import 'package:vls_app/pages/videos/widgets/video_card.dart';
import 'package:vls_app/providers/video.provider.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Gallery'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed:
                () =>
                    Provider.of<VideoProvider>(
                      context,
                      listen: false,
                    ).refreshVideos(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Consumer<VideoProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.videos.isEmpty) {
            return Center(child: Text('No videos available'));
          }
          return ListView.builder(
            itemCount: provider.videos.length,
            itemBuilder: (context, index) {
              final video = provider.videos[index];
              return VideoCard(video: video);
            },
          );
        },
      ),
    );
  }
}
