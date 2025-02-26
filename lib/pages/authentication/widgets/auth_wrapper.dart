import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/authentication/sign_in_page.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/widgets/navigation_layout.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return authProvider.isAuthenticated ? NavigationLayout() : SignInPage();
  }
}
