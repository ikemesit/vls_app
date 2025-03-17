import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/news/widgets/news_card.dart';
import 'package:vls_app/providers/post.provider.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, postsProvider, child) {
        if (postsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (postsProvider.posts.isEmpty) {
          return Center(
            child: Column(
              children: [
                Image(image: AssetImage(TImages.noDataImage)),
                Gap(10.0),
                Text('No news available'),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Latest News',
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
                        Provider.of<PostsProvider>(
                          context,
                          listen: false,
                        ).refreshPosts(),
                tooltip: 'Refresh',
              ),
            ],
          ),
          body: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            itemCount: postsProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postsProvider.posts[index];
              return NewsCard(
                imageUrl:
                    post.featuredImage.isEmpty
                        ? 'https://www.flagsonline.it/uploads/2016-6-6/1200-0/suriname.jpg'
                        : post.featuredImage,
                headline: post.headline,
                excerpt: post.content,
                datePosted: post.createdAt,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Gap(15.0);
            },
          ),
        );
      },
    );
  }
}
