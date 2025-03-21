import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/user_profile/widgets/user_profile_setup.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';

import '../../../utils/theme/custom_themes/text_theme.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Form(
      key: signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              label: Text('Email', style: TTextTheme.lightTextTheme.labelSmall),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            controller: emailController,
          ),
          const SizedBox(height: 30.0),
          Text(
            'Enter your password',
            style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              label: Text(
                'Enter your password',
                style: TTextTheme.lightTextTheme.labelSmall,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            controller: passwordController,
          ),
          const SizedBox(height: 30.0),
          Text(
            'Confirm your password',
            style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              label: Text(
                'Confirm password',
                style: TTextTheme.lightTextTheme.labelSmall,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            controller: confirmPasswordController,
          ),
          SizedBox(height: 50.0),
          Row(
            children: [
              Consumer<AuthProvider>(
                builder:
                    (context, auth, _) => Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (signUpFormKey.currentState!.validate()) {
                            try {
                              await auth.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              if (context.mounted) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const UserProfileSetupScreen(),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                Flushbar(
                                  title: "Error",
                                  message: e.toString(),
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
                        child: Text(auth.isLoading ? 'Loading...' : 'Register'),
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
