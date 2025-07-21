import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _languageKey = 'selected_language';

  LanguageBloc() : super(const LanguageState()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadLanguage(
    LoadLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey) ?? 'en';

      final locale = languageCode == 'id'
          ? const Locale('id', 'ID')
          : const Locale('en', 'US');

      emit(state.copyWith(locale: locale));
    } catch (e) {
      // If there's an error loading preferences, default to English
      emit(state.copyWith(locale: const Locale('en', 'US')));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguage event,
    Emitter<LanguageState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, event.locale.languageCode);
      emit(state.copyWith(locale: event.locale));
    } catch (e) {
      // If there's an error saving preferences, still emit the state change
      emit(state.copyWith(locale: event.locale));
    }
  }
}
