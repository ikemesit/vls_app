import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/authentication/sign_in_page.dart';
import 'package:vls_app/pages/settings/change_password_page.dart';
import 'package:vls_app/pages/settings/settings.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/providers/profile_picture.provider.dart';
import '../pages/user_profile/user_profile_page.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/theme/custom_themes/text_theme.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String profilePicUrl = '';
  String userId = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserProfilePicture(context);
    });
  }

  void _getUserProfilePicture(BuildContext context) {
    Provider.of<ProfilePictureProvider>(
      context,
      listen: false,
    ).fetchProfilePicture(
      Provider.of<AuthProvider>(context, listen: false).user!.id,
    );

    String response =
        Provider.of<ProfilePictureProvider>(
          context,
          listen: false,
        ).profilePictureUrl ??
        '';

    setState(() {
      profilePicUrl = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        if (!auth.isAuthenticated) {
          return Drawer(
            backgroundColor: TColors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              itemExtent: MediaQuery.of(context).size.height,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image(
                      image: const AssetImage(TImages.notAuthorizedImage),
                      height: 200.0,
                    ),
                    Gap(40.0),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInPage(),
                                ),
                              );
                            },
                            child: Text('Sign in'),
                            // style: ElevatedButton.styleFrom()
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // ListTile(
                //   leading: const Icon(Icons.settings),
                //   trailing: const Icon(Icons.chevron_right),
                //   title: const Text('Settings'),
                //   titleAlignment: ListTileTitleAlignment.center,
                //   titleTextStyle: TTextTheme.lightTextTheme.headlineSmall,
                //   minVerticalPadding: 20.0,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => SettingsPage()),
                //     );
                //   },
                // ),
              ],
            ),
          );
        } else {
          return Drawer(
            backgroundColor: TColors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: TColors.primary),
                  child: Center(
                    child:
                        profilePicUrl.length == 0
                            ? CircleAvatar(
                              radius: 100.0,
                              child: Icon(Icons.person, size: 100.0),
                            )
                            : CircleAvatar(
                              radius: 100.0,
                              foregroundImage: NetworkImage(profilePicUrl),
                            ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  trailing: const Icon(Icons.chevron_right),
                  title: const Text('Profile'),
                  subtitle: const Text('View and edit your profile'),
                  titleAlignment: ListTileTitleAlignment.center,
                  titleTextStyle: TTextTheme.lightTextTheme.headlineSmall,
                  minVerticalPadding: 20.0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  trailing: const Icon(Icons.chevron_right),
                  title: const Text('Change Password'),
                  subtitle: const Text('Update your password'),
                  titleAlignment: ListTileTitleAlignment.center,
                  titleTextStyle: TTextTheme.lightTextTheme.headlineSmall,
                  minVerticalPadding: 20.0,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordPage(),
                      ),
                    );
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.language),
                //   trailing: const Icon(Icons.chevron_right),
                //   title: const Text('Language'),
                //   subtitle: const Text('Select app language'),
                //   titleAlignment: ListTileTitleAlignment.center,
                //   titleTextStyle: TTextTheme.lightTextTheme.headlineSmall,
                //   minVerticalPadding: 20.0,
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                ListTile(
                  leading: const Icon(Icons.info),
                  trailing: const Icon(Icons.chevron_right),
                  title: const Text('About'),
                  subtitle: const Text('App version and information'),
                  titleAlignment: ListTileTitleAlignment.center,
                  titleTextStyle: TTextTheme.lightTextTheme.headlineSmall,
                  minVerticalPadding: 20.0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  subtitle: const Text('Sign out of your account'),
                  titleAlignment: ListTileTitleAlignment.center,
                  titleTextStyle: TTextTheme.lightTextTheme.headlineSmall,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  minVerticalPadding: 20.0,
                  onTap: () {
                    auth.signOut();
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
