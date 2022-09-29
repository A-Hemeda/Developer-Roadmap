import 'package:booking_app/core/utilis/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static final darkMode = ThemeData(
    scaffoldBackgroundColor: AppColors.kPrimaryColor,
    colorScheme: const ColorScheme.dark(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkGrey,
      selectedItemColor: AppColors.teal,
      unselectedItemColor: AppColors.grey,
      elevation: 20,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        color: AppColors.teal,
      ),
      unselectedLabelStyle: const TextStyle(
        color: AppColors.grey,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.teal,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kPrimaryColor,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(
        color: AppColors.teal,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade900,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.grey,
        height: 1.3,
      ),
    ),
  );
  static final lightMode = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.teal,
      unselectedItemColor: AppColors.grey,
      elevation: 20,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        color: AppColors.teal,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.grey,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.teal,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      titleTextStyle: const TextStyle(
          color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(
        color: AppColors.teal,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade900,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.grey,
        height: 1.3,
      ),
    ),
  );
}
