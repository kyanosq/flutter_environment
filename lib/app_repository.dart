import 'dart:convert';
import 'package:environment/preference_type.dart';
import 'package:environment/service_center.dart';
import 'package:get_it/get_it.dart';

import 'environment.dart';
import 'app_state.dart';

class AppRepository {
  static String get _storeKey =>
      'com.repository.environment${inProduction ? 'pro' : 'dev'}';

  static Future<AppState> fromStorage(PreferenceType preference) async {
    try {
      final jsonString = preference.getString(_storeKey);
      final json = JsonDecoder().convert(jsonString) as Map<String, dynamic>;
      return AppState.fromJson(json);
    } catch (e) {
      return preference.remove(_storeKey).then((value) => null);
    }
  }

  static Future<bool> saveState(AppState state) async {
    final json = state.toJson();
    final environmentString = JsonEncoder().convert(json);
    final preference = GetIt.instance.get<ServiceCenter>().preferences;
    return preference.setString(_storeKey, environmentString);
  }

  static Future<bool> clearState() async {
    try {
      final preference = GetIt.instance.get<ServiceCenter>().preferences;
      return preference.remove(_storeKey);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
