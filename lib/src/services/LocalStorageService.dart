import 'package:shared_preferences/shared_preferences.dart';

mixin StorageKeys {
  static const String token = 'TOKEN';
}

mixin LocalStorageService {
  static SharedPreferences _prefs;

  static Future<dynamic> _getInstance() async => _prefs = await SharedPreferences.getInstance();

  static Future<String> get(String key) async {
    await _getInstance();
    return _prefs.getString(key);
  }

  static Future<void> set(String key, String value) async {
    await _getInstance();
    await _prefs.setString(key, value);
  }

  static Future<void> remove(String key) async {
    await _getInstance();
    await _prefs.remove(key);
  }
}

