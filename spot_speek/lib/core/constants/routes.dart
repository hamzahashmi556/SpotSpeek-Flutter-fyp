import 'package:flutter/material.dart';
import 'package:spot_speek/presentation/views/login_screen.dart';
import 'package:spot_speek/presentation/views/onboarding_screen.dart';
import 'package:spot_speek/presentation/views/signup_screen.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const Text('Home'));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found!')),
          ),
        );
    }
  }
}
