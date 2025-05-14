class CookieService {
  static String? _cookie;
  static String? get cookie => _cookie;

  static void setCookie(String value) {
    _cookie = value;
  }

  static bool get isCookieAvailable => _cookie != null;
}
