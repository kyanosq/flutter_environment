import 'package:environment/preference_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';
import 'database.dart';
import 'http.dart';
import 'package:flutter/material.dart';

/// 集成基础功能服务, 如HTTP请求, 键值存储等
class ServiceCenter {
  AppState _state;

  /// 网络层
  HTTPServiceType get httpService => _httpService;
  HTTPServiceType _httpService;

  /// 键值存储
  PreferenceType get preferences => _preferences;
  PreferenceType _preferences;

  /// 数据库存储
  DatabaseType get database => _database;
  DatabaseType _database;

  /// 默认构造方法
  ServiceCenter(
      {@required HTTPServiceType httpService,
      @required PreferenceType preferences,
      @required DatabaseType database})
      : this._httpService = httpService,
        this._preferences = preferences,
        this._database = database;

  /// 开发环境
  ServiceCenter.development(
      AppState appState, SharedPreferences sharedPreferences) {
    _httpService = _httpService.update(
        locale: appState.settings.locale,
        baseUrl: appState.environment.baseUrl,
        logMode: appState.environment.logMode,
        token: appState.token);
    _preferences = SharedPreferencesBox(sharedPreferences);
    // database = Da
  }

  /// 生产环境
  ServiceCenter.production(
      AppState appState, SharedPreferences sharedPreferences) {
    _httpService = _httpService.update(
        locale: appState.settings.locale,
        baseUrl: appState.environment.baseUrl,
        logMode: appState.environment.logMode,
        token: appState.token);
    _preferences = SharedPreferencesBox(sharedPreferences);
    // database = Da
  }

  /// 集成及单元测试
  ServiceCenter.integrationTest(AppState appState,
      {PreferenceType preferenceType}) {
    _httpService = _httpService.update(
        locale: appState.settings.locale,
        baseUrl: appState.environment.baseUrl,
        logMode: appState.environment.logMode,
        token: appState.token);
    // _preferences = preferenceType ?? MockPrefrence
    // database = Da
  }

  void update(AppState newState) {
    final oldState = _state;
    _state = newState;
    if (newState.token != oldState.token ||
        newState.environment != oldState.environment ||
        newState.settings.locale != oldState.settings.locale) {
      _httpService = _httpService.update(
          token: _state.token,
          baseUrl: _state.environment.baseUrl,
          logMode: _state.environment.logMode,
          locale: _state.settings.locale);
    }
  }
}
