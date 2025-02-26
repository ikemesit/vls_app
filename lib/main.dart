import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vls_app/pages/authentication/sign_in_page.dart';
import 'package:vls_app/pages/authentication/widgets/auth_wrapper.dart';
import 'package:vls_app/providers/authentication.provider.dart';
import 'package:vls_app/providers/donation.provider.dart';
import 'package:vls_app/providers/event.provider.dart';
import 'package:vls_app/providers/user_profile.provider.dart';
import 'package:vls_app/providers/video.provider.dart';
import 'package:vls_app/utils/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://srmnihaohewhedrqnenm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNybW5paGFvaGV3aGVkcnFuZW5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAzMDg2NTQsImV4cCI6MjA1NTg4NDY1NH0.spouRiTdQRGrIyZFTZ6fRa31WRYll4n7n8X1iFuTNfM',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProxyProvider<AuthProvider, DonationProvider>(
          create:
              (context) => DonationProvider(
                Provider.of<AuthProvider>(context, listen: false).user?.id,
              ),
          update:
              (context, auth, previous) =>
                  DonationProvider.update(auth.user?.id, previous),
        ),
        // ChangeNotifierProxyProvider<AuthProvider, UserProfileProvider>(
        //   create: (context) => UserProfileProvider(userId:
        //     Provider.of<AuthProvider>(context, listen: false).user?.id,
        //   ),
        //   update: (context, auth, previous) => UserProfileProvider.update(
        //     auth.user?.id,
        //     previous,
        //   ),
        // ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      // ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}
