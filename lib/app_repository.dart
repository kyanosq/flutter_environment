import 'dart:convert';
import 'environment.dart';
import 'system_settings.dart';

import 'app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepository {
  static String get _storeKey =>
      'com.repository.environment${inProduction ? 'pro' : 'dev'}';

  Future<AppInitialized> restoreFromCache() async {
    AppState appState;
    try {
      final preference = await SharedPreferences.getInstance();
      final jsonString = preference.getString(_storeKey);
      final json = JsonDecoder().convert(jsonString) as Map<String, dynamic>;
      AppInitialized state;
      if (inProduction) {
        final environment = await Environment.initial();
        state = AppInitialized.fromJson(json, environment: environment);
      } else {
        state = AppInitialized.fromJson(json);
      }
      appState = state;
    } catch (e) {
      _clearEnvironment();
    }
    if (appState == null) {
      final environment = await Environment.initial();
      final settings = SystemSettings.empty();
      appState = AppInitialized(
          environment: environment, systemSettings: settings, token: '');
    }
    return appState;
  }

  void _clearEnvironment() async {
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
