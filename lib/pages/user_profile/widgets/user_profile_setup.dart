import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/models/user_profile.model.dart';
import 'package:vls_app/pages/user_profile/widgets/profile_picture_upload.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

import '../../../providers/authentication.provider.dart';

class UserProfileSetupScreen extends StatefulWidget {
  const UserProfileSetupScreen({super.key});

  @override
  UserProfileSetupScreenState createState() => UserProfileSetupScreenState();
}

class UserProfileSetupScreenState extends State<UserProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _ninController;

  DateTime? _dob;
  String? _gender;
  String? _citizenshipStatus;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _ninController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _ninController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Setup Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload your profile picture',
                style: TTextTheme.lightTextTheme.titleMedium,
              ),
              Gap(10.0),
              Container(
                decoration: BoxDecoration(
                  color: TColors.softGrey,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: TColors.darkGrey, width: 1.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: Center(
                  child: ProfilePictureUploadWidget(
                    userId:
                        Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).user!.id,
                  ),
                ),
              ),
              Gap(20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        label: Text(
                          'First Name',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _middleNameController,
                      decoration: InputDecoration(
                        label: Text(
                          'Middle Name',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        label: Text(
                          'Last Name',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        label: Text(
                          'Email',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        label: Text(
                          'Phone',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    ListTile(
                      title: Text(
                        _dob == null
                            ? 'Date of Birth'
                            : 'DOB: ${_dob!.toString().substring(0, 10)}',
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) setState(() => _dob = date);
                      },
                    ),
                    Gap(20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        label: Text(
                          'Gender',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      value: _gender,
                      items:
                          ['Male', 'Female', 'Other']
                              .map(
                                (g) =>
                                    DropdownMenuItem(value: g, child: Text(g)),
                              )
                              .toList(),
                      onChanged: (value) => setState(() => _gender = value),
                      validator: (value) => value == null ? 'Required' : null,
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        label: Text(
                          'Address',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        label: Text(
                          'City',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _stateController,
                      decoration: InputDecoration(
                        label: Text(
                          'State',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    TextFormField(
                      controller: _ninController,
                      decoration: InputDecoration(
                        label: Text(
                          'National Identification Number',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    Gap(20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        label: Text(
                          'Citizenship Status',
                          style: TTextTheme.lightTextTheme.labelSmall,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      value: _citizenshipStatus,
                      items:
                          ['Citizen', 'Resident', 'Non-resident']
                              .map(
                                (s) =>
                                    DropdownMenuItem(value: s, child: Text(s)),
                              )
                              .toList(),
                      onChanged:
                          (value) => setState(() => _citizenshipStatus = value),
                      validator: (value) => value == null ? 'Required' : null,
                    ),
                    Gap(20),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Consumer<UserProfileProvider>(
                          builder:
                              (context, userProfileProvider, _) => Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate() &&
                                        _dob != null) {
                                      try {
                                        final profile = UserProfile(
                                          firstname: _firstNameController.text,
                                          middlename:
                                              _middleNameController.text,
                                          lastname: _lastNameController.text,
                                          dob: _dob!,
                                          gender: _gender!,
                                          email: _emailController.text,
                                          phone: _phoneController.text,
                                          address: _addressController.text,
                                          city: _cityController.text,
                                          state: _stateController.text,
                                          nin: _ninController.text,
                                          citizenshipStatus:
                                              _citizenshipStatus!,
                                          userId:
                                              Provider.of<AuthProvider>(
                                                context,
                                                listen: false,
                                              ).user!.id,
                                        );

                                        await userProfileProvider
                                            .createUserProfile(profile);

                                        if (context.mounted) {
                                          Flushbar(
                                            title: "Success",
                                            message: "Profile Saved!",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: TColors.success,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                            padding: EdgeInsets.all(20.0),
                                            margin: EdgeInsets.symmetric(
                                              vertical: 20.0,
                                              horizontal: 10.0,
                                            ),
                                            icon: Lottie.asset(
                                              TImages.animatedSuccess,
                                              width: 50.0,
                                              repeat: false,
                                            ),
                                          ).show(context);
                                        }

                                        await Future.delayed(
                                          const Duration(seconds: 2),
                                        );

                                        if (context.mounted) {
                                          Navigator.of(
                                            context,
                                          ).popUntil((route) => route.isFirst);
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          Flushbar(
                                            title: "Error",
                                            message: 'Could not save profile!',
                                            duration: Duration(seconds: 3),
                                            animationDuration: Duration(
                                              milliseconds: 590,
                                            ),
                                            backgroundColor: TColors.error,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
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
                                              width: 50.0,
                                              repeat: false,
                                            ),
                                          ).show(context);
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    userProfileProvider.isLoading
                                        ? 'Saving...'
                                        : 'Save Profile',
                                  ),
                                ),
                              ),
                        ),
                      ],
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
