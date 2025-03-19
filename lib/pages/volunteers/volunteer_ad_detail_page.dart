import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../models/volunteer_ad.model.dart';

class VolunteerAdDetailPage extends StatelessWidget {
  final VolunteerAd ad;

  const VolunteerAdDetailPage({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final isExpired = ad.expiresAt.isBefore(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text(ad.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ad.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Gap(16),
            Text(
              'Description',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Gap(8),
            Html(
              data: ad.description.replaceAll('&nbsp;', ' '),
              style: {
                "p": Style(
                  whiteSpace: WhiteSpace.pre,
                  textAlign: TextAlign.left,
                  display: Display.block,
                ),
              },
            ),
            Gap(16),
            Text(
              'Created: ${DateFormat('MMM d, yyyy').format(ad.createdAt)}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Expires: ${DateFormat('MMM d, yyyy').format(ad.expiresAt)}',
              style: TextStyle(
                fontSize: 14.0,
                color: isExpired ? Colors.red : Colors.grey[700],
              ),
            ),
            if (isExpired) ...[
              SizedBox(height: 16),
              Chip(
                label: Text('Expired'),
                backgroundColor: Colors.red[100],
                labelStyle: TextStyle(color: Colors.red),
              ),
            ],
            SizedBox(height: 24),
            if (!isExpired)
              ElevatedButton(
                onPressed: () {
                  // Handle volunteer sign-up logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signed up for volunteering!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text('Sign Up to Volunteer'),
              ),
          ],
        ),
      ),
    );
  }
}
