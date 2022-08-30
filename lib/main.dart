import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'localization/app_localizations_delegate.dart';
import 'pages/home/home_page.dart';
import 'pages/home/loading_page.dart';
import 'providers/asmaallah_provider.dart';
import 'providers/azkar_provider.dart';
import 'providers/categories_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/prayer_provider.dart';
import 'providers/sebha_provider.dart';
import 'providers/sections_provider.dart';
import 'providers/settings_provider.dart';
import 'services/services_export.dart';
import 'util/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  tz.initializeTimeZones();
  await NotificationServices().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SectionsProvider>(
            create: (context) => SectionsProvider()),
        ChangeNotifierProvider<SettingsProvider>(
            create: (context) => SettingsProvider()..get_data()),
        ChangeNotifierProvider<CategoriesProvider>(
            create: (context) => CategoriesProvider()),
        ChangeNotifierProvider<SebhaProvider>(
            create: (context) => SebhaProvider()),
        ChangeNotifierProvider<AzkarProvider>(
            create: (context) => AzkarProvider()),
        ChangeNotifierProvider<FavoritesProvider>(
            create: (context) => FavoritesProvider()),
        ChangeNotifierProvider<PrayerProvider>(
            create: (context) => PrayerProvider()),
        ChangeNotifierProvider<AsmaAllahProvider>(
            create: (context) => AsmaAllahProvider()),
      ],
      child: MaterialApp(
        title: 'Azkary',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme(context),
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizationsDelegate.supportedLocales(),
        localeResolutionCallback: AppLocalizationsDelegate.resolution,
        home: Consumer<SectionsProvider>(
            builder: (context, sectionProvider, widget) {
          return sectionProvider.isNewUser
              ? FutureBuilder(
                  future: sectionProvider.tryToGetData(context),
                  builder: (context, result) {
                    if (result.connectionState == ConnectionState.waiting) {
                      debugPrint(' The page is  Loading !!');
                      return const LoadingPage();
                    } else {
                      debugPrint(' Username is Hemeda ');
                      return const HomePage();
                    }
                  },
                )
              : const HomePage();
        }),
      ),
    );
  }
}
