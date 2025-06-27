bool isArabic(String text) {
  if (text.isEmpty) return false;
  return text.codeUnits[0] >= 0x600 && text.codeUnits[0] <= 0x6FF;
}
