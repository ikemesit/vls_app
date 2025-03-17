import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/events/widgets/event_details.dart';
import 'package:vls_app/pages/news/news_details.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/utils/helpers/helper_functions.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

class EventCard extends StatelessWidget {
  final String id;
  final String headline;
  final String description;
  final DateTime date;
  final DateTime datePosted;
  final List<String> images;

  const EventCard({
    super.key,
    required this.id,
    required this.headline,
    required this.description,
    required this.images,
    required this.date,
    required this.datePosted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        THelperFunctions.navigateToScreen(
          context,
          EventDetails(
            id: id,
            headline: headline,
            description: description,
            date: date,
            datePosted: datePosted,
            images: images,
            userId: Provider.of<AuthProvider>(context, listen: false).user!.id,
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
                imageUrl: images[0],
                width: double.infinity,
                height: 200.0,
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
                      Icon(Icons.calendar_today, color: Colors.grey[700]),
                      Gap(10.0),
                      Text(
                        DateFormat.yMMMEd().format(date).toString(),
                        style: TTextTheme.lightTextTheme.bodySmall,
                      ),
                    ],
                  ),
                  // const Gap(10.0),
                  // Row(
                  //   children: [
                  //     Icon(Icons.access_time, color: Colors.grey[700]),
                  //     Gap(10.0),
                  //     Text(
                  //       DateFormat.yMMMEd().format(datePosted).toString(),
                  //       style: TTextTheme.lightTextTheme.bodySmall,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
