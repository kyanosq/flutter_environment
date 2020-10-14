import 'package:shared_preferences/shared_preferences.dart';

/// 键值存储抽象层
abstract class PreferenceType {
  Set<String> getKeys();

  dynamic get(String key);

  bool getBool(String key);

  int getInt(String key);

  double getDouble(String key);

  String getString(String key);

  bool containsKey(String key);

  List<String> getStringList(String key);

  Future<bool> setBool(String key, bool value);

  Future<bool> setInt(String key, int value);

  Future<bool> setDouble(String key, double value);

  Future<bool> setString(String key, String value);

  Future<bool> setStringList(String key, List<String> value);

  Future<bool> remove(String key);

  Future<bool> clear();

  Future<void> reload();
}

/// 键值存储默认实现
class SharedPreferencesBox implements PreferenceType {
  final SharedPreferences preferences;

  SharedPreferencesBox(this.preferences);

  @override
  Future<bool> clear() {
    return preferences.clear();
  }

  @override
  bool containsKey(String key) {
    return preferences.containsKey(key);
  }

  @override
  get(String key) {
    return preferences.get(key);
  }

  @override
  bool getBool(String key) {
    return preferences.getBool(key);
  }

  @override
  double getDouble(String key) {
    return preferences.getDouble(key);
  }

  @override
  int getInt(String key) {
    return preferences.getInt(key);
  }

  @override
  Set<String> getKeys() {
    return preferences.getKeys();
  }

  @override
  String getString(String key) {
    return preferences.getString(key);
  }

  @override
  List<String> getStringList(String key) {
    return preferences.getStringList(key);
  }

  @override
  Future<void> reload() {
    return preferences.reload();
  }

  @override
  Future<bool> remove(String key) {
    return preferences.remove(key);
  }

  @override
  Future<bool> setBool(String key, bool value) {
    return preferences.setBool(key, value);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return preferences.setDouble(key, value);
  }

  @override
  Future<bool> setInt(String key, int value) {
    return preferences.setInt(key, value);
  }

  @override
  Future<bool> setString(String key, String value) {
    return preferences.setString(key, value);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    return preferences.setStringList(key, value);
  }
}
