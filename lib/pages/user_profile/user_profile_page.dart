import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/models/user_profile.model.dart';
import 'package:vls_app/pages/authentication/sign_in_page.dart';
import 'package:vls_app/pages/user_profile/widgets/edit_user_profile.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  _editProfile(BuildContext context, UserProfile profile) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditUserProfilePage(profile: profile)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          Consumer<UserProfileProvider>(
            builder:
                (context, provider, _) => IconButton(
                  icon: Icon(Icons.edit),
                  onPressed:
                      provider.profile != null
                          ? () => _editProfile(
                            context,
                            provider.profile as UserProfile,
                          )
                          : null,
                ),
          ),
        ],
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.profile == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage(TImages.notAuthorizedImage),
                  height: 300.0,
                ),
                Gap(40.0),
                Text('Please log in to view your profile'),
                Gap(20.0),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignInPage()),
                            );
                          },
                          child: Text('Sign In'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          //

          final profile = provider.profile;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(profile!),
                Gap(20.0),
                _buildProfileSection('Personal Information', [
                  _buildProfileItem('First Name', profile.firstname),
                  Gap(5.0),
                  _buildProfileItem('Middle Name', profile.middlename),
                  Gap(5.0),
                  _buildProfileItem('Last Name', profile.lastname),
                  Gap(5.0),
                  _buildProfileItem(
                    'Date of Birth',
                    profile.dob.toString().substring(0, 10),
                  ),
                  Gap(5.0),
                  _buildProfileItem('Gender', profile.gender),
                ]),
                _buildProfileSection('Contact Information', [
                  _buildProfileItem('Email', profile.email),
                  Gap(5.0),
                  _buildProfileItem('Phone', profile.phone),
                ]),
                _buildProfileSection('Address', [
                  _buildProfileItem('Address', profile.address),
                  Gap(5.0),
                  _buildProfileItem('City', profile.city),
                  Gap(5.0),
                  _buildProfileItem('State', profile.state),
                ]),
                _buildProfileSection('Identification', [
                  _buildProfileItem('NIN', profile.nin),
                  Gap(5.0),
                  _buildProfileItem(
                    'Citizenship Status',
                    profile.citizenshipStatus,
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(UserProfile profile) {
    return Card(
      color: TColors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                '${profile.firstname[0]}${profile.lastname[0]}',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.firstname} ${profile.lastname}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(profile.email, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          color: TColors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
            child: Column(children: items),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TTextTheme.lightTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: TTextTheme.lightTextTheme.bodySmall),
        ),
      ],
    );
  }
}
