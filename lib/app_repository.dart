import 'dart:convert';
import 'environment.dart';
import 'app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepository {
  static String get _storeKey =>
      'com.repository.environment${inProduction ? 'pro' : 'dev'}';

  Future<AppInitialized> restoreFromCache() async {
    try {
      final preference = await SharedPreferences.getInstance();
      final jsonString = preference.getString(_storeKey);
      final json = JsonDecoder().convert(jsonString) as Map<String, dynamic>;
      return AppInitialized.fromJson(json);
    } catch (e) {
      _clearState();
      return null;
    }
  }

  void _clearState() async {
    final preference = await SharedPreferences.getInstance();
    await preference.remove(_storeKey);
  }

  Future<bool> saveState(AppInitialized state) async {
    final json = state.toJson();
    final environmentString = JsonEncoder().convert(json);
    final preference = await SharedPreferences.getInstance();
    return preference.setString(_storeKey, environmentString);
  }
}
