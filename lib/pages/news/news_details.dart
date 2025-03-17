import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../utils/constants/colors.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class NewsDetails extends StatelessWidget {
  final String imageUrl;
  final String headline;
  final String excerpt;
  final DateTime datePosted;

  const NewsDetails({
    super.key,
    required this.imageUrl,
    required this.headline,
    required this.excerpt,
    required this.datePosted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Details'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              // height: 300.0, //TODO ensure pictures maintain 1280x720 size (communicate with client)
              fit: BoxFit.contain,
              progressIndicatorBuilder:
                  (context, url, progress) => Center(
                    child: CircularProgressIndicator(value: progress.progress),
                  ),
            ),
            Gap(15.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    style: TTextTheme.lightTextTheme.headlineMedium,
                  ),
                  Gap(5.0),
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
                  Divider(
                    color: TColors.borderPrimary,
                    thickness: 1.0,
                    height: 50.0,
                  ),
                  Wrap(
                    children: [
                      Html(
                        data: excerpt.replaceAll('&nbsp;', ' '),
                        style: {
                          "p": Style(
                            whiteSpace: WhiteSpace.pre,
                            textAlign: TextAlign.left,
                            display: Display.block,
                          ),
                        },
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
