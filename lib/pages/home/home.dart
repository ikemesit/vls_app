import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/authentication/sign_in_page.dart';
import 'package:vls_app/pages/authentication/sign_up_page.dart';
import 'package:vls_app/pages/donations/donations_page.dart';
import 'package:vls_app/pages/home/widgets/carousel_item.dart';
import 'package:vls_app/pages/news/news_page.dart';
import 'package:vls_app/pages/news/widgets/news_card.dart';
import 'package:vls_app/pages/home/widgets/quick_action_button.dart';
import 'package:vls_app/pages/videos/widgets/video_card.dart';
import 'package:vls_app/pages/volunteers/volunteers_ads_page.dart';
import 'package:vls_app/providers/banners.provider.dart';
import 'package:vls_app/providers/event.provider.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/providers/video.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/helpers/helper_functions.dart';
import 'package:vls_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

import '../../providers/authentication.provider.dart';
import '../../providers/post.provider.dart';
import '../../utils/constants/image_strings.dart';
import '../events/widgets/event_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final CarouselSliderController _controller = CarouselSliderController();

  int _currentSlideIndex = 0;

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
        Provider.of<AuthProvider>(context, listen: false).user?.id;

    if (currentUserId != null) {
      await provider.fetchUserProfile(currentUserId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          primary: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const Gap(30.0),
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  autoPlayInterval: const Duration(seconds: 8),
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentSlideIndex = index;
                    });
                  },
                ),
                items:
                    Provider.of<BannerProvider>(context, listen: false).banners
                        .map((bannerUrl) => CarouselItem(imageUrl: bannerUrl))
                        .toList(),
              ),
              Gap(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    Provider.of<BannerProvider>(
                      context,
                      listen: false,
                    ).banners.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(
                                  _currentSlideIndex == entry.key ? 0.9 : 0.4,
                                ),
                          ),
                        ),
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
                            if (Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).isAuthenticated) {
                              Flushbar(
                                title: "Error",
                                message: 'You are already registered',
                                duration: Duration(seconds: 3),
                                animationDuration: Duration(milliseconds: 590),
                                backgroundColor: TColors.error,
                                flushbarStyle: FlushbarStyle.FLOATING,
                                borderRadius: BorderRadius.circular(8.0),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 20.0,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 10.0,
                                ),
                                icon: Lottie.asset(
                                  TImages.animatedError,
                                  width: 50.0,
                                  height: 50.0,
                                  repeat: false,
                                ),
                              ).show(context);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder:
                                      (BuildContext context) => const SignUp(),
                                ),
                              );
                            }
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
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder:
                                    (BuildContext context) =>
                                        const VolunteerAdsPage(),
                              ),
                            );
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

              TabBar(
                controller: _tabController,
                indicatorColor: TColors.primary,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.0,
                isScrollable: true,
                labelColor: TColors.primary,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Press Release'),
                  Tab(text: 'Latest Events'),
                  Tab(text: 'Latest Videos'),
                ],
              ),
              const Gap(20.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.3,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Consumer<PostsProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (provider.posts.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(TImages.noDataImage),
                                  width: 150.0,
                                ),
                                Gap(10.0),
                                Text('No posts available'),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.posts.length,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          itemBuilder: (BuildContext context, int index) {
                            final post = provider.posts[index];

                            return NewsCard(
                              imageUrl:
                                  post.featuredImage.isEmpty
                                      ? 'https://www.flagsonline.it/uploads/2016-6-6/1200-0/suriname.jpg'
                                      : post.featuredImage,
                              headline: post.headline,
                              excerpt: post.content,
                              datePosted: post.createdAt,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10.0);
                          },
                        );
                      },
                    ),
                    Consumer<EventsProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (provider.events.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(TImages.noDataImage),
                                  width: 150.0,
                                ),
                                Gap(10.0),
                                Text('No events available'),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.events.length,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          itemBuilder: (BuildContext context, int index) {
                            final event = provider.events[index];

                            return EventCard(
                              id: event.id,
                              date: event.date,
                              images: event.images,
                              headline: event.headline,
                              description: event.description,
                              datePosted: event.datePosted,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10.0);
                          },
                        );
                      },
                    ),
                    Consumer<VideoProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (provider.videos.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(TImages.noDataImage),
                                  width: 150.0,
                                ),
                                Gap(10.0),
                                Text('No videos available'),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.videos.length,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          itemBuilder: (BuildContext context, int index) {
                            final video = provider.videos[index];

                            return VideoCard(video: video);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10.0);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
