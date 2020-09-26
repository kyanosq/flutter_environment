import 'environment.dart';
import 'system_settings.dart';

abstract class AppState {}

class AppUninitialized extends AppState {}

class AppInitialized extends AppState {
  /// 系统设置, 如声音等
  final SystemSettings systemSettings;
  final Environment environment;
  final String token;

  AppInitialized({this.systemSettings, this.environment, this.token});

  factory AppInitialized.fromJson(Map<String, dynamic> json,
          {Environment environment}) =>
      AppInitialized(
        systemSettings: SystemSettings.fromJson(json['systemSettings']),
        environment: environment ?? Environment.fromJson(json['environment']),
        token: json['token'],
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'systemSettings': systemSettings.toJson(),
      'environment': environment.toJson(),
      'token': token,
    };
  }

  AppInitialized update({
    SystemSettings systemSettings,
    Environment environment,
    String token,
  }) {
    return copyWith(
        systemSettings: systemSettings, environment: environment, token: token);
  }

  AppInitialized copyWith({
    SystemSettings systemSettings,
    Environment environment,
    String token,
  }) {
    return AppInitialized(
      systemSettings: systemSettings ?? this.systemSettings,
      environment: environment ?? this.environment,
      token: token ?? this.token,
    );
  }
}
