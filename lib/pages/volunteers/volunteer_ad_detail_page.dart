import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/providers/volunteer_ad.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';
import 'package:vls_app/utils/helpers/helper_functions.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

import '../../models/volunteer_ad.model.dart';
import '../authentication/sign_in_page.dart';

class VolunteerAdDetailPage extends StatefulWidget {
  final VolunteerAd ad;
  final String? userId;

  const VolunteerAdDetailPage({super.key, required this.ad, this.userId});

  @override
  State<VolunteerAdDetailPage> createState() => _VolunteerAdDetailPageState();
}

class _VolunteerAdDetailPageState extends State<VolunteerAdDetailPage> {
  bool isVolunteer = false;
  bool hasFetchedVolunteers = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserAttendance();
    });
  }

  Future<void> fetchUserAttendance() async {
    if (widget.userId == null) return;

    final provider = Provider.of<VolunteerAdProvider>(context, listen: false);
    await provider.fetchVolunteerById(widget.ad.id, widget.userId!);

    setState(() {
      isVolunteer = provider.adVolunteer != null;
      hasFetchedVolunteers = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = widget.ad.expiresAt.isBefore(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text(widget.ad.title), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.ad.title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Gap(16),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Gap(8),
                Html(
                  data: widget.ad.description.replaceAll('&nbsp;', ' '),
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
                  'Created: ${DateFormat('MMM d, yyyy').format(widget.ad.createdAt)}',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
                Gap(8),
                Text(
                  'Expires: ${DateFormat('MMM d, yyyy').format(widget.ad.expiresAt)}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: isExpired ? Colors.red : Colors.grey[700],
                  ),
                ),
                if (isExpired) ...[
                  Chip(
                    label: Text('Expired'),
                    backgroundColor: Colors.red[100],
                    labelStyle: TextStyle(color: Colors.red),
                  ),
                ],
                Gap(24),

                Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    if (!isExpired) {
                      if (provider.isAuthenticated) {
                        if (!isVolunteer) {
                          return ElevatedButton(
                            onPressed: () {
                              try {
                                Provider.of<VolunteerAdProvider>(
                                  context,
                                  listen: false,
                                ).confirmUserAsVolunteer(
                                  widget.ad.id,
                                  provider.user!.id,
                                );

                                fetchUserAttendance();

                                THelperFunctions.showAlert(
                                  context,
                                  'Success!',
                                  'You have signed up as a volunteer!.',
                                  Lottie.asset(
                                    TImages.animatedSuccess2,
                                    repeat: false,
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                );
                              } catch (e) {}
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                            ),
                            child: Text('Sign Up to Volunteer'),
                          );
                        } else {
                          return Text(
                            'You are already registered as a Volunteer',
                            style: TTextTheme.lightTextTheme.labelMedium
                                ?.copyWith(color: TColors.success),
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
                            'Sign in to register as a Volunteer',
                            style: TTextTheme.lightTextTheme.bodySmall,
                          ),
                        );
                      }
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
