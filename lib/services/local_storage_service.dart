import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();
  static final LocalStorageService instance = LocalStorageService._();
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyLastLoginAt = 'last_login_at';

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> _ensurePrefs() async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _ensurePrefs();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await _ensurePrefs();
    await prefs.setBool(_keyIsLoggedIn, value);
    if (value) {
      await prefs.setInt(
        _keyLastLoginAt,
        DateTime.now().millisecondsSinceEpoch,
      );
    }
  }

  Future<void> saveUserProfile({String? name, String? email}) async {
    final prefs = await _ensurePrefs();
    if (name != null) {
      await prefs.setString(_keyUserName, name);
    }
    if (email != null) {
      await prefs.setString(_keyUserEmail, email);
    }
  }

  Future<String?> getUserName() async {
    final prefs = await _ensurePrefs();
    return prefs.getString(_keyUserName);
  }

  Future<String?> getUserEmail() async {
    final prefs = await _ensurePrefs();
    return prefs.getString(_keyUserEmail);
  }

  Future<int?> getLastLoginAt() async {
    final prefs = await _ensurePrefs();
    return prefs.getInt(_keyLastLoginAt);
  }

  Future<void> clearSession() async {
    final prefs = await _ensurePrefs();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyLastLoginAt);
  }
}
