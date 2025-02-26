import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:vls_app/pages/news/news_details.dart';
import 'package:vls_app/utils/helpers/helper_functions.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String headline;
  final String excerpt;
  final DateTime datePosted;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.headline,
    required this.excerpt,
    required this.datePosted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        THelperFunctions.navigateToScreen(
          context,
          NewsDetails(
            imageUrl: imageUrl,
            headline: headline,
            excerpt: excerpt,
            datePosted: datePosted,
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
                progressIndicatorBuilder:
                    (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20.0),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.grey[500]),
                      Gap(10.0),
                      Text(
                        DateFormat.yMMMEd().format(datePosted).toString(),
                        style: TTextTheme.lightTextTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
