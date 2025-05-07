import 'package:bookly_app/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeHelper {
  static double descriptionFontSize = 16;
  static double titleFontSize = 30;

  static Future<void> defaultFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFontSize = prefs.getInt(KFontKeySize) ?? 2;
    await changeFontSize(savedFontSize);
  }

  static Future<void> changeFontSize(int fontNumber) async {
    switch (fontNumber) {
      case 1:
        descriptionFontSize = 12;
        titleFontSize = 24;
        break;
      case 2:
        descriptionFontSize = 16;
        titleFontSize = 30;
        break;
      case 3:
        descriptionFontSize = 20;
        titleFontSize = 36;
        break;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(KFontKeySize, fontNumber);
  }
}
