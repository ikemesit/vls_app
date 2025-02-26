import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/models/user_profile.model.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

class UserProfileSetupScreen extends StatefulWidget {
  const UserProfileSetupScreen({super.key});

  @override
  _UserProfileSetupScreenState createState() => _UserProfileSetupScreenState();
}

class _UserProfileSetupScreenState extends State<UserProfileSetupScreen> {
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
      appBar: AppBar(title: Text('Setup Profile')),
      body: Consumer<UserProfileProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.userId == null) {
            return Center(child: Text('Please log in to create a profile'));
          }

          if (provider.profile != null) {
            return Center(child: Text('Profile already exists'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
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
                              (g) => DropdownMenuItem(value: g, child: Text(g)),
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
                              (s) => DropdownMenuItem(value: s, child: Text(s)),
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              provider.isLoading
                                  ? null
                                  : () async {
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
                                          userId: provider.userId!,
                                        );

                                        await provider.createUserProfile(
                                          profile,
                                        );
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text('Profile saved'),
                                            ),
                                          );
                                          Navigator.of(
                                            context,
                                          ).popUntil((route) => route.isFirst);
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                          child: Text(
                            provider.isLoading ? 'Saving...' : 'Save Profile',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
