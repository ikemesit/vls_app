import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/events/widgets/event_card.dart';
import 'package:vls_app/providers/event.provider.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsProvider>(
      builder: (context, eventsProvider, child) {
        if (eventsProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (eventsProvider.events.isEmpty) {
          return Center(
            child: Column(
              children: [
                Image(image: AssetImage(TImages.noDataImage)),
                Gap(10.0),
                Text('No events available'),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Upcoming Events',
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
                        Provider.of<EventsProvider>(
                          context,
                          listen: false,
                        ).refreshEvents(),
                tooltip: 'Refresh',
              ),
            ],
          ),
          body: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            itemCount: eventsProvider.events.length,
            itemBuilder: (context, index) {
              final event = eventsProvider.events[index];
              return EventCard(
                id: event.id,
                headline: event.headline,
                description: event.description,
                images: event.images,
                date: event.date,
                datePosted: event.datePosted,
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
