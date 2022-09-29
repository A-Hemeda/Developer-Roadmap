import 'dart:async';
import 'package:booking_app/core/local/cache_helper.dart';
import 'package:booking_app/core/routes/routes_manager.dart';
import 'package:booking_app/core/utilis/constants/app_strings.dart';
import 'package:booking_app/core/utilis/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/utilis/constants/colors.dart';
import '../../core/utilis/constants/constats_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer =
        Timer(const Duration(milliseconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    String token = CacheHelper.getData(key: AppStrings.token) ?? '';
    if (token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, Routes.homeLayout);
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.loginRoute,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Center(
        child: Lottie.asset(JsonAssets.splashLogo),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
