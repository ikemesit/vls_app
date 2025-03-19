import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../models/volunteer_ad.model.dart';
import '../../../utils/constants/colors.dart';
import '../volunteer_ad_detail_page.dart';

class VolunteerAdCard extends StatelessWidget {
  final VolunteerAd ad;

  const VolunteerAdCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final isExpired = ad.expiresAt.isBefore(DateTime.now());

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: TColors.white,
      child: InkWell(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VolunteerAdDetailPage(ad: ad)),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ad.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Gap(8),
              Divider(color: TColors.grey, thickness: 1.0),
              Gap(8),
              Html(
                data:
                    ad.description.length > 150
                        ? '${ad.description.substring(0, 150).replaceAll('&nbsp;', ' ')}...'
                        : ad.description.replaceAll('&nbsp;', ' '),
                style: {
                  "p": Style(
                    whiteSpace: WhiteSpace.pre,
                    textAlign: TextAlign.left,
                    display: Display.block,
                  ),
                },
              ),
              Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expires: ${DateFormat('MMM d, yyyy').format(ad.expiresAt)}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isExpired ? Colors.red : Colors.grey[700],
                    ),
                  ),
                  if (isExpired)
                    Chip(
                      label: Text('Expired'),
                      backgroundColor: Colors.red[100],
                      labelStyle: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
