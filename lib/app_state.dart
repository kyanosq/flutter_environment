import 'package:flutter/material.dart';

import 'environment.dart';
import 'settings.dart';

class AppState {
  /// 系统设置, 如声音等
  final Settings settings;

  /// 环境设置, 如baseUrl, 调试日志等, 生产环境下仅baseUrl生效
  final Environment environment;

  /// token
  final String token;

  AppState({@required this.settings, @required this.environment, this.token});

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
        settings: Settings.fromJson(json['settings']),
        environment: Environment.fromJson(json['environment']),
        token: json['token'],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'settings': settings.toJson(),
      'environment': environment.toJson(),
      'token': token,
    };
  }

  AppState update({
    Settings settings,
    Environment environment,
    String token,
  }) {
    return copyWith(settings: settings, environment: environment, token: token);
  }

  AppState copyWith({
    Settings settings,
    Environment environment,
    String token,
  }) {
    return AppState(
      settings: settings ?? this.settings,
      environment: environment ?? this.environment,
      token: token ?? this.token,
    );
  }
}
