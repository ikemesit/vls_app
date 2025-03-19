import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/volunteers/widgets/volunteer_ad_card.dart';

import '../../providers/volunteer_ad.provider.dart';

class VolunteerAdsPage extends StatelessWidget {
  const VolunteerAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Opportunities'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed:
                () =>
                    Provider.of<VolunteerAdProvider>(
                      context,
                      listen: false,
                    ).refreshAds(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Consumer<VolunteerAdProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.ads.isEmpty) {
            return Center(child: Text('No volunteer opportunities available'));
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            itemCount: provider.ads.length,
            itemBuilder: (context, index) {
              final ad = provider.ads[index];
              return VolunteerAdCard(ad: ad);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Gap(10.0);
            },
          );
        },
      ),
    );
  }
}
