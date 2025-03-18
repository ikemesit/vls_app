import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/videos/widgets/video_card.dart';
import 'package:vls_app/providers/video.provider.dart';
import 'package:vls_app/utils/constants/image_strings.dart';

import '../../utils/constants/colors.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video Gallery',
          style: TTextTheme.lightTextTheme.headlineSmall,
        ),
        backgroundColor: TColors.white,
        elevation: 2.0,
        shadowColor: TColors.black.withAlpha(50),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: TColors.black),
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
      body: SafeArea(
        child: Consumer<VideoProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (provider.videos.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Image(image: AssetImage(TImages.noDataImage)),
                    Gap(10.0),
                    Text('No videos available'),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: provider.videos.length,
              itemBuilder: (context, index) {
                final video = provider.videos[index];
                return VideoCard(video: video);
              },
              separatorBuilder: (context, index) => Gap(8.0),
            );
          },
        ),
      ),
    );
  }
}
