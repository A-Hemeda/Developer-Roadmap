import 'package:bloc/bloc.dart';
import 'package:booking_app/core/app_localization/language_cache_helper.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('en')));

  Future<void> getSaveLanguage() async {
    final String cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LanguageCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
