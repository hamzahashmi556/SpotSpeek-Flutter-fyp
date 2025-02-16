import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_speek/core/constants/app_colors.dart';
import 'package:spot_speek/core/constants/routes.dart';
import 'package:spot_speek/data/repositories/auth_repository.dart';
// import 'package:spot_speek/domain/repositories/auth_repository.dart';
import 'package:spot_speek/firebase_options.dart';
import 'package:spot_speek/core/constants/app_providers.dart';
import 'package:spot_speek/presentation/views/create_account.dart';
import 'package:spot_speek/presentation/views/home_screen.dart';
import 'package:spot_speek/presentation/views/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await FirebaseAuth.instance.signOut();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseUIManager.configure();
  runApp(MultiProvider(providers: AppProviders.providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  static const themeColor = AppColors.primary;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spot Speek',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: themeColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: themeColor,
          )),
          textTheme: const TextTheme(
              displayMedium: TextStyle(color: Colors.brown),
              displayLarge: TextStyle(color: themeColor))),
      home: StreamBuilder<User?>(
        stream: context.read<AuthRepository>().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const OnboardingScreen();
          }
        },
      ),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
