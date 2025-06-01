import 'package:bookly_app/Features/settings/data/repos/settings_repo.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeSettingsCubit extends Cubit<ChangeSettingsState> {
  ChangeSettingsCubit(this.settingsRepo) : super(ChangeSettingsInitial()) {
    loadTheme();
    defaultFontSize();
    emit(ChangeSettingsSuccess());
  }

  final SettingsRepo settingsRepo;
  List<Color> get geminiColors => theme == Brightness.light
      ? [
          Color(0xFFF3E8FF), // Pastel Purple
          Color(0xFFFCE7F3), // Pastel Pink
          Color(0xFFE0F2FE), // Sky Blue
        ]
      : [
          Color(0xFF1A0B2E), // Deep Purple (قريب من الأسود بس فيه لمسة أرجواني)
          Color(0xFF2A1B3D), // Dark Indigo (مزيج من الأرجواني والأزرق الغامق)
          Color(0xFF4A1A3F), // Dark Plum (لمسة Pink غامقة للحيوية)
        ];
  /////////////////////////////////////////////
  List<Color> get gradientColors => theme == Brightness.dark
      ? [
          // بنفسجي فاتح باستيل
          // Colors.grey,
          // const Color(0xFF37474F)
          // const Color.fromARGB(255, 0, 166, 243),
          const Color(0xFF9C27B0),
          Colors.grey,

          // const Color(0xFFE1BEE7),

          // const Color(0xFF6A1B9A), // بنفسجي غامق هادي
          // const Color(0xFF263238), // رمادي مزرق غامق
        ]
      : [
          const Color(0xFF9C27B0),
          Colors.grey,
        ];
  ///////////////////////
  List<Color> get questionsColors => theme == Brightness.dark
      ? [
          Colors.grey.shade700.withOpacity(0.5), // رمادي شفاف
          const Color(0xFFa23757), // أحمر كشميري
          Colors.blue.withOpacity(0.5), // أزرق رمادي
        ]
      : [
          const Color(0xFFE0E0E0), // رمادي فاتح
          const Color(0xFFF06292), // وردي ناعم
          const Color(0xFF90CAF9), //
        ];
//////////Change Font Size//////////
  double descriptionFontSize = 16;
  double titleFontSize = 30;
  int fontIndex = 2;

  Future<void> defaultFontSize() async {
    fontIndex = await settingsRepo.getFontIndex();
    changeFontSize(fontIndex);
  }

  void changeFontSize(int fontNumber) async {
    switch (fontNumber) {
      case 1:
        fontIndex = 1;
        descriptionFontSize = 12;
        titleFontSize = 24;
        break;
      case 2:
        fontIndex = 2;
        descriptionFontSize = 16;
        titleFontSize = 30;
        break;
      case 3:
        fontIndex = 3;
        descriptionFontSize = 20;
        titleFontSize = 36;
        break;
    }
    await settingsRepo.saveFontIndex(fontNumber);
    emit(ChangeSettingsSuccess());
  }

/////////////Change Theme////////////////
  final hour = DateTime.now().hour;
  Brightness theme = Brightness.dark;
  int themeIndex = 3;
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
  /////////////////////////////

  Future loadTheme() async {
    final savedTheme = await settingsRepo.getThemeIndex();
    changeTheme(savedTheme);
  }

//////////////////////////////////////
  changeTheme(int themeType) async {
    switch (themeType) {
      case 1:
        themeIndex = 1;
        theme = Brightness.light;
        backgroundColor = Colors.white;
        iconColor = Colors.black;

        break;
      case 2:
        themeIndex = 2;
        theme = Brightness.dark;
        backgroundColor = Colors.black;
        iconColor = Colors.white;

        break;
      case 3:
        themeIndex = 3;
        theme = defaultTheme();

        break;
    }
    await settingsRepo.saveThemeIndex(themeType);
    emit(ChangeSettingsSuccess());
  }
}
