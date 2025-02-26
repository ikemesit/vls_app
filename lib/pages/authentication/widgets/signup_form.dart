import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/user_profile/widgets/user_profile_setup.dart';
import 'package:vls_app/providers/authentication.provider.dart';

import '../../../utils/theme/custom_themes/text_theme.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Form(
      key: formKey,
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
                          if (formKey.currentState!.validate()) {
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                            }
                          }
                        },
                        child: Text('Register'),
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
