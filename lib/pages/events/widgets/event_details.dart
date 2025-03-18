import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/authentication/sign_in_page.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/providers/event.provider.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/utils/constants/image_strings.dart';
import 'package:vls_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({
    super.key,
    required this.id,
    required this.headline,
    required this.description,
    required this.date,
    required this.datePosted,
    required this.images,
    required this.userId,
  });
  final String id;
  final String userId;
  final String headline;
  final String description;
  final DateTime date;
  final DateTime datePosted;
  final List<String> images;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isAttendee = false;
  bool hasFetchedAttendance = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserAttendance();
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   isAttendee = false;
  //   hasFetchedAttendance = false;
  // }

  Future<void> fetchUserAttendance() async {
    final provider = Provider.of<EventsProvider>(context, listen: false);
    await provider.fetchEventAttendanceByUserId(widget.id, widget.userId);

    setState(() {
      isAttendee = provider.attendance != null;
      hasFetchedAttendance = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Details'), centerTitle: true),
      backgroundColor: TColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // width: MediaQuery.of(context).size.width,
              height: 300.0,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  final image = widget.images[index];
                  return CachedNetworkImage(
                    imageUrl: image,
                    width: MediaQuery.of(context).size.width,
                    height:
                        300.0, //TODO ensure pictures maintain 1280x720 size (communicate with client)
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, progress) => Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                  );
                },
                separatorBuilder: (context, index) => Gap(5.0),
              ),
            ),
            Gap(15.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.headline,
                    style: TTextTheme.lightTextTheme.headlineMedium,
                  ),
                  Gap(5.0),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey[500],
                      ),
                      Gap(10.0),
                      Text(
                        DateFormat.yMMMEd()
                            .format(widget.datePosted)
                            .toString(),
                        style: TTextTheme.lightTextTheme.bodySmall,
                      ),
                    ],
                  ),
                  Divider(
                    color: TColors.borderPrimary,
                    thickness: 1.0,
                    height: 50.0,
                  ),
                  Text(
                    'About Event',
                    style: TTextTheme.lightTextTheme.labelMedium,
                  ),
                  Html(data: widget.description.replaceAll('&nbsp;', ' ')),
                  Gap(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, provider, child) {
                          if (provider.isAuthenticated) {
                            if (hasFetchedAttendance) {
                              if (isAttendee) {
                                return Text(
                                  'You are already registered for this event',
                                  style: TTextTheme.lightTextTheme.labelMedium
                                      ?.copyWith(color: TColors.success),
                                );
                              } else {
                                return FilledButton(
                                  onPressed: () {
                                    try {
                                      Provider.of<EventsProvider>(
                                        context,
                                        listen: false,
                                      ).confirmEventAttendance(
                                        widget.id,
                                        provider.user!.id,
                                      );

                                      fetchUserAttendance();

                                      THelperFunctions.showAlert(
                                        context,
                                        'Success!',
                                        'You have confirmed your attendance',
                                        Lottie.asset(
                                          TImages.animatedSuccess2,
                                          repeat: false,
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                      );
                                    } catch (e) {
                                      Flushbar(
                                        title: "Error",
                                        message: 'An error occurred',
                                        duration: Duration(seconds: 3),
                                        animationDuration: Duration(
                                          milliseconds: 590,
                                        ),
                                        backgroundColor: TColors.error,
                                        flushbarStyle: FlushbarStyle.FLOATING,
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        padding: EdgeInsets.all(20.0),
                                        margin: EdgeInsets.symmetric(
                                          vertical: 20.0,
                                          horizontal: 10.0,
                                        ),
                                        icon: Lottie.asset(
                                          TImages.animatedError,
                                          repeat: false,
                                        ),
                                      ).show(context);
                                    }
                                  },
                                  child: Text('Confirm attendance'),
                                );
                              }
                            } else {
                              return CircularProgressIndicator(
                                color: TColors.success,
                              );
                            }
                          } else {
                            return OutlinedButton(
                              onPressed: () {
                                THelperFunctions.navigateToScreen(
                                  context,
                                  SignInPage(),
                                );
                              },
                              child: Text(
                                'Sign in to confirm event attendance',
                                style: TTextTheme.lightTextTheme.bodySmall,
                              ),
                            );
                          }
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
