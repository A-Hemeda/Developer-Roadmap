import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:azkark/services/notification_services.dart';
import 'package:azkark/util/print_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
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
import 'util/app_theme.dart';

///TODO Step 3 of 3
startApp() async {
  tz.initializeTimeZones();
  await NotificationServices().initNotification();
}

///TODO Step 2 of 3
void printHello() async {
  await startApp();
  final String now = DateFormat('hh:mm a').format(DateTime.now()).toString();
  final int isolateId = Isolate.current.hashCode;
  printLog(
      stateID: "442902",
      data: "[$now] الوقت =$isolateId ='$printHello'",
      isSuccess: true);

  NotificationServices().showNotification(
      1, "وقت الصلاة الآن", "[$now] الوقت =$isolateId ='$printHello'", 3);
}

///TODO Step 1 of 3
partOne() async {
  const int alarmID = 0;
  DateTime nextTimeAlarm = DateTime.parse("2022-08-22 12:26");
  await AndroidAlarmManager.oneShotAt(nextTimeAlarm, alarmID, printHello);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await partOne();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
                      print(' The page is  Loading !!');
                      return LoadingPage();
                    } else {
                      print(' Username is Hemeda ');
                      return HomePage();
                    }
                  },
                )
              : HomePage();
        }),
      ),
    );
  }
}
