import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/authentication/sign_up_page.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/widgets/navigation_layout.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(backgroundColor: TColors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: const AssetImage(TImages.loginOrSignupImage),
                height: 250.0,
              ),
            ),
            Text(
              'Login or Sign Up',
              style: TTextTheme.lightTextTheme.headlineLarge,
            ),

            Gap(30.0),
            Form(
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
                  Gap(10.0),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      label: Text(
                        'Enter your email',
                        style: TTextTheme.lightTextTheme.labelSmall,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  Gap(30.0),
                  Text(
                    'Enter your password',
                    style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(10.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(
                        'Enter your password',
                        style: TTextTheme.lightTextTheme.labelSmall,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  Gap(40.0),
                  Row(
                    children: [
                      Consumer<AuthProvider>(
                        builder:
                            (context, auth, _) => Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      await auth.signIn(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );

                                      if (context.mounted) {
                                        Navigator.of(context).pop(context);
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(e.toString()),
                                            backgroundColor: TColors.error,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  auth.isLoading ? 'Loading...' : 'Login',
                                ),
                              ),
                            ),
                      ),
                    ],
                  ),
                  Gap(10.0),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder:
                                    (BuildContext context) => const SignUp(),
                              ),
                            );
                          },
                          child: Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                  Gap(5.0),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 20.0,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder:
                                      (BuildContext context) =>
                                          const NavigationLayout(),
                                ),
                              );
                            },
                            child: Text(
                              'Skip for now',
                              style: TTextTheme.lightTextTheme.titleMedium,
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
    );
  }
}
