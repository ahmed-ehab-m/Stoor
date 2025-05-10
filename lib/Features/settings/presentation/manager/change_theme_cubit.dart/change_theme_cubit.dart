import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_state.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(ChangeThemeInitial()) {
    loadTheme();
    emit(ChangeThemeSuccess());
  }
  final hour = DateTime.now().hour;

  Brightness theme = Brightness.dark;
  Color? backgroundColor = Colors.white;
  Color? iconColor = Colors.black;
  Brightness defaultTheme() {
    if (hour >= 5 && hour < 17) {
      backgroundColor = Colors.white;
      iconColor = Colors.black;
      return Brightness.light;
    } else {
      backgroundColor = Colors.black;
      iconColor = Colors.white;

      return Brightness.dark;
    }
  }

  Future loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getInt(KThemeyKey) ?? 3;
    changeTheme(savedTheme, save: false);
  }

  changeTheme(int themeType, {bool save = true}) async {
    switch (themeType) {
      case 1:
        theme = Brightness.light;
        backgroundColor = Colors.white;
        iconColor = Colors.black;

        break;
      case 2:
        theme = Brightness.dark;
        backgroundColor = Colors.black;
        iconColor = Colors.white;

        break;
      case 3:
        theme = defaultTheme();

        break;
    }
    emit(ChangeThemeSuccess());
    if (save) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(KThemeyKey, themeType);
    }
  }

  Future<void> saveThemeIndex(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(KThemeyKey, value);
  }
}
