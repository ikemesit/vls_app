import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/authentication/sign_in_page.dart';
import 'package:vls_app/pages/donations/donations_page.dart';
import 'package:vls_app/pages/home/widgets/content_type_selector.dart';
import 'package:vls_app/pages/home/widgets/carousel_item.dart';
import 'package:vls_app/pages/home/widgets/news_card.dart';
import 'package:vls_app/pages/home/widgets/quick_action_button.dart';
import 'package:vls_app/providers/event.provider.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

import '../../providers/authentication.provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<CarouselItem> carouselItems = [
    CarouselItem(
      imageUrl:
          "https://images.pexels.com/photos/13966908/pexels-photo-13966908.jpeg",
      headline: "Join us for a better Suriname",
    ),
    CarouselItem(
      imageUrl:
          "https://aborntraveller.com/wp-content/uploads/2022/01/Whats-it-like-to-live-in-Paramaribo-Suriname-for-13-years-4-1.jpg",
      headline: "All about Suriname",
    ),
    CarouselItem(
      imageUrl:
          "https://unitednews.sr/wp-content/uploads/2023/08/robert-visnudat.jpg",
      headline: "Interview with Robert Vishnudath",
    ),
    CarouselItem(
      imageUrl:
          "https://images.pexels.com/photos/13966908/pexels-photo-13966908.jpeg",
      headline: "Join us for a better Suriname",
    ),
    CarouselItem(
      imageUrl:
          "https://images.pexels.com/photos/13966908/pexels-photo-13966908.jpeg",
      headline: "Join us for a better Suriname",
    ),
  ];

  final List<String> misc = [
    'Join us for a better Suriname',
    'Heading 2',
    'Heading 3',
  ];

  final List<String> feeds = ['Events', 'News', 'Videos'];

  int selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserProfile();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> fetchUserProfile() async {
    final provider = Provider.of<UserProfileProvider>(context, listen: false);
    final currentUserId =
        Provider.of<AuthProvider>(context, listen: false).user?.id as String;
    print('Current User ID');
    print(currentUserId);
    await provider.fetchUserProfile(currentUserId);
    print('After fetch User Profile in Home');
    print(provider.profile?.firstname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 20.0),
          child: SizedBox.shrink(),
        ),
        shadowColor: Colors.black.withValues(
          alpha: 0.5,
          red: 0,
          blue: 0,
          green: 0,
        ),
        backgroundColor: TAppBarTheme.lightAppBarTheme.backgroundColor,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/14653174/pexels-photo-14653174.jpeg',
                ),
                // Add your profile image in assets
                radius: 20.0,
              ),
            ),
            SizedBox(width: 4.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Consumer<UserProfileProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      provider.profile?.firstname ?? 'Guest',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: TColors.black, size: 30),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(30.0),
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                enlargeCenterPage: false,
                autoPlayInterval: const Duration(seconds: 8),
              ),
              items:
                  carouselItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CarouselItem(
                          imageUrl: item.imageUrl,
                          headline: item.headline,
                        );
                      },
                    );
                  }).toList(),
            ),
            const Gap(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Quick Actions',
                    style: TTextTheme.lightTextTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder:
                                  (BuildContext context) => const SignInPage(),
                            ),
                          );
                        },
                        child: QuickActionButton(
                          label: 'Join VLS',
                          icon: Icon(
                            Icons.group_add,
                            size: 30,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder:
                                  (BuildContext context) =>
                                      const DonationsPage(),
                            ),
                          );
                        },
                        child: QuickActionButton(
                          label: 'Donate',
                          icon: Icon(
                            Icons.attach_money,
                            size: 30,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        radius: 8.0,
                        onTap: () {
                          // Handle button tap
                        },
                        child: QuickActionButton(
                          label: 'Volunteer',
                          icon: Icon(
                            Icons.help,
                            size: 30,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(30.0),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 10.0,
            //     horizontal: 15.0,
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Text(
            //         'Activities',
            //         style: TTextTheme.lightTextTheme.titleLarge,
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 40.0,
            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       ListView.separated(
            //         shrinkWrap: true,
            //         scrollDirection: Axis.horizontal,
            //         physics: ScrollPhysics(),
            //         itemCount: feeds.length,
            //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //         itemBuilder: (BuildContext context, int index) {
            //           final item = feeds[index];
            //           return InkWell(
            //             onTap: () {
            //               setState(() {
            //                 selectedIndex = index; // Update the selected index
            //               });
            //             },
            //             child: ContentTypeSelector(
            //               isSelected: selectedIndex == index,
            //               label: item,
            //             ),
            //           );
            //         },
            //         separatorBuilder: (BuildContext context, int index) {
            //           return const Gap(10.0);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            TabBar(
              controller: _tabController,
              indicatorColor: TColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.0,
              labelColor: TColors.primary,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Press Release'),
                Tab(text: 'Events'),
                Tab(text: 'News'),
              ],
            ),
            const Gap(20.0),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.5,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Consumer<EventsProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.events.length,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        itemBuilder: (BuildContext context, int index) {
                          final event = provider.events[index];
                          return NewsCard(
                            imageUrl: event.images[0],
                            headline: event.headline,
                            excerpt: event.description,
                            datePosted: event.datePosted,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 10.0);
                        },
                      );
                    },
                  ),

                  Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
