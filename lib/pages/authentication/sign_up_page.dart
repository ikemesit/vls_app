import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vls_app/pages/authentication/widgets/signup_form.dart';

import '../../utils/constants/colors.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/logos/vls-splash-logo.jpg')),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 20.0,
                ),
                child: Text(
                  'Sign up to become a member of VLS',
                  style: TTextTheme.lightTextTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Gap(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: SignUpForm(),
            ),
          ],
        ),
      ),
    );
  }
}
