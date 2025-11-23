import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torrents_digger/configs/app_theme.dart';
import 'package:torrents_digger/configs/colors.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: DarkTheme())) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme_name') ?? 'Dark';
    AppTheme theme;

    switch (themeName) {
      case 'Light':
        theme = LightTheme();
        break;
      case 'Tokyo Blue':
        theme = TokyoBlueTheme();
        break;
      case 'Blue':
        theme = BlueTheme();
        break;
      case 'Dark':
      default:
        theme = DarkTheme();
        break;
    }

    AppColors.currentTheme = theme;
    emit(ThemeState(themeData: theme));
  }

  Future<void> _onChangeTheme(
    ChangeTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_name', event.theme.name);
    AppColors.currentTheme = event.theme;
    emit(ThemeState(themeData: event.theme));
  }
}
