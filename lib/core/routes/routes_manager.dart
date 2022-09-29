import 'package:booking_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:booking_app/features/auth/register/presentation/screens/signup_screen.dart';
import 'package:booking_app/features/search/presentation/screens/search.dart';
import 'package:booking_app/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../features/home/presentation/screens/layout/layoutScreen.dart';
import '../utilis/constants/app_strings.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeLayout = '/homeLayout';
  static const String search = '/search';
  static const String hotelView = '/hotelView';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case Routes.homeLayout:
        return MaterialPageRoute(builder: (context) => const HomeLayout());
      case Routes.search:
        return MaterialPageRoute(builder: (context) => const Search());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
