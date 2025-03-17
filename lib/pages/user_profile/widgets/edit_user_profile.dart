import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/models/user_profile.model.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

class EditUserProfilePage extends StatefulWidget {
  final UserProfile profile;

  const EditUserProfilePage({super.key, required this.profile});

  @override
  EditUserProfilePageState createState() => EditUserProfilePageState();
}

class EditUserProfilePageState extends State<EditUserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController(
      text: widget.profile.firstname,
    );
    _middleNameController = TextEditingController(
      text: widget.profile.middlename,
    );
    _lastNameController = TextEditingController(text: widget.profile.lastname);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _addressController = TextEditingController(text: widget.profile.address);
    _cityController = TextEditingController(text: widget.profile.city);
    _stateController = TextEditingController(text: widget.profile.state);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Edit Profile')),
      body: Consumer<UserProfileProvider>(
        builder:
            (context, provider, _) => SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(50.0),
                    Text(
                      'First Name',
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    Gap(20.0),
                    Text(
                      'Middle Name',
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    Gap(20.0),
                    Text(
                      'Last Name',
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    Gap(20.0),
                    Text(
                      'Phone',
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    Gap(20.0),
                    Text(
                      'Address',
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    Gap(20.0),
                    Text(
                      'City',
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    Gap(20.0),
                    Text(
                      'State',
                      style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    Gap(20.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                provider.isLoading
                                    ? () {}
                                    : () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          final updatedProfile = UserProfile(
                                            id: widget.profile.id,
                                            firstname:
                                                _firstNameController.text,
                                            middlename:
                                                _middleNameController.text,
                                            lastname: _lastNameController.text,
                                            dob: widget.profile.dob,
                                            gender: widget.profile.gender,
                                            email: widget.profile.email,
                                            phone: _phoneController.text,
                                            address: _addressController.text,
                                            city: _cityController.text,
                                            state: _stateController.text,
                                            nin: widget.profile.nin,
                                            citizenshipStatus:
                                                widget
                                                    .profile
                                                    .citizenshipStatus,
                                            userId: widget.profile.userId,
                                          );
                                          await provider.updateUserProfile(
                                            updatedProfile,
                                          );

                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                            Flushbar(
                                              title: "Success",
                                              message: "Profile Updated!",
                                              duration: Duration(seconds: 3),
                                              backgroundColor: TColors.success,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              padding: EdgeInsets.all(20.0),
                                              margin: EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 10.0,
                                              ),
                                              icon: Lottie.asset(
                                                TImages.animatedSuccess,
                                                repeat: false,
                                              ),
                                            ).show(context);
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            Flushbar(
                                              title: "Error",
                                              message:
                                                  'Could not update profile',
                                              duration: Duration(seconds: 3),
                                              animationDuration: Duration(
                                                milliseconds: 590,
                                              ),
                                              backgroundColor: TColors.error,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                        }
                                      }
                                    },
                            child: Text(
                              provider.isLoading ? 'Saving...' : 'Save Changes',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
