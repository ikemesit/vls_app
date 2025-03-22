import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    final changePasswordFormKey = GlobalKey<FormState>();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: changePasswordFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40.0),
              Text(
                'New Password',
                style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  label: Text('New Password'),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                controller: newPasswordController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
              ),
              const Gap(20.0),
              Text(
                'Confirm New Password',
                style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  label: Text('Confirm new Password'),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                controller: confirmPasswordController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }

                  if (value != newPasswordController.text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },
              ),
              const Gap(40.0),
              Row(
                children: [
                  Consumer<AuthProvider>(
                    builder:
                        (context, auth, _) => Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (changePasswordFormKey.currentState!
                                  .validate()) {
                                try {
                                  await auth.updatePassword(
                                    newPassword: newPasswordController.text,
                                  );

                                  if (context.mounted) {
                                    Flushbar(
                                      title: "Success",
                                      message: "Password Updated!",
                                      duration: Duration(seconds: 3),
                                      backgroundColor: TColors.success,
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      borderRadius: BorderRadius.circular(8.0),
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
                                } catch (e) {
                                  if (context.mounted) {
                                    Flushbar(
                                      title: "Error",
                                      message: 'Could not update password',
                                      duration: Duration(seconds: 3),
                                      animationDuration: Duration(
                                        milliseconds: 590,
                                      ),
                                      backgroundColor: TColors.error,
                                      flushbarStyle: FlushbarStyle.FLOATING,
                                      borderRadius: BorderRadius.circular(8.0),
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
                            child: Text(auth.isLoading ? 'Saving...' : 'Save'),
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
