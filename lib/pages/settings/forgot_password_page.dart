import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/utils/constants/colors.dart';
import 'package:vls_app/utils/constants/image_strings.dart';
import 'package:vls_app/utils/helpers/helper_functions.dart';
import 'package:vls_app/utils/theme/custom_themes/text_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    // final controller =
    //     WebViewController()
    //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //       ..setNavigationDelegate(
    //         NavigationDelegate(
    //           onProgress: (int progress) {
    //             Center(
    //               child: CircularProgressIndicator(color: TColors.success),
    //             );
    //           },
    //           onPageStarted: (String url) {},
    //           onPageFinished: (String url) {},
    //           onHttpError: (HttpResponseError error) {},
    //           onWebResourceError: (WebResourceError error) {},
    //           onNavigationRequest: (NavigationRequest request) {
    //             if (request.url.startsWith('https://www.youtube.com/')) {
    //               return NavigationDecision.prevent;
    //             }
    //             return NavigationDecision.navigate;
    //           },
    //         ),
    //       )
    //       ..loadRequest(
    //         Uri.parse('https://vls-party.web.app/reset-user-password'),
    //       );

    // WebViewWidget(controller: controller)

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(40.0),
                  Text(
                    'Enter your email address to reset your password',
                    style: TTextTheme.lightTextTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const Gap(40),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              try {
                                Provider.of<AuthProvider>(
                                  context,
                                  listen: false,
                                ).resetPassword(
                                  email:
                                      emailController.text.trim().toLowerCase(),
                                );

                                THelperFunctions.showAlert(
                                  context,
                                  'Success!',
                                  'Password reset email sent successfully. Please check your inbox.',
                                  Lottie.asset(
                                    TImages.animatedSuccess2,
                                    repeat: false,
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                );
                              } catch (e) {
                                Flushbar(
                                  title: "Error",
                                  message: 'An error occurred',
                                  duration: Duration(seconds: 3),
                                  animationDuration: Duration(
                                    milliseconds: 590,
                                  ),
                                  backgroundColor: TColors.error,
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                  borderRadius: BorderRadius.circular(8.0),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 20.0,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 10.0,
                                  ),
                                  icon: Lottie.asset(
                                    TImages.animatedError,
                                    width: 50.0,
                                    height: 50.0,
                                    repeat: false,
                                  ),
                                ).show(context);
                              }
                            }
                          },
                          child: const Text('Reset Password'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
