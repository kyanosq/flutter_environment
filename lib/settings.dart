import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
/*
system 为跟随系统设置, 字体会动态缩放
其余选项为app内锁定字体大小
* */
enum FontScaleMode { system, normal, large, veryLarge }
// enum VideoAutoPlayMode { none, wifi, all }

const FontScaleModeEnumMap = {
  FontScaleMode.system: 'system',
  FontScaleMode.normal: 'normal',
  FontScaleMode.large: 'large',
  FontScaleMode.veryLarge: 'veryLarge',
};

class Settings extends Equatable {
  final bool soundEnabled;

  final FontScaleMode fontScaleMode;
  final Locale locale;

  const Settings({this.soundEnabled, this.fontScaleMode, this.locale});

  Settings.empty()
      : soundEnabled = false,
        fontScaleMode = FontScaleMode.system,
        locale = Locale('en_US');

  @override
  List<Object> get props => [soundEnabled, fontScaleMode, locale];

  factory Settings.fromJson(Map<String, dynamic> json) {
    final languageCode = json['languageCode'] as String;
    final countryCode = json['countryCode'] as String;
    Locale locale;
    if (isNotEmpty(languageCode)) {
      locale = Locale(languageCode, countryCode);
    }
    return Settings(
      soundEnabled: json['soundEnabled'] as bool,
      fontScaleMode: FontScaleModeEnumMap.entries
          .singleWhere((e) => e.value == json['fontScaleMode'],
          orElse: () => null)
          ?.key,
      locale: locale,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'soundEnabled': soundEnabled,
      'fontScaleMode': FontScaleModeEnumMap[fontScaleMode],
      'languageCode': locale?.languageCode,
      'countryCode': locale?.countryCode
    };
  }

  Settings update({
    bool soundEnabled,
    FontScaleMode fontScaleMode,
    Locale locale,
  }) {
    return copyWith(
        soundEnabled: soundEnabled,
        fontScaleMode: fontScaleMode,
        locale: locale);
  }

  Settings copyWith({
    bool soundEnabled,
    FontScaleMode fontScaleMode,
    Locale locale,
  }) {
    return Settings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      fontScaleMode: fontScaleMode ?? this.fontScaleMode,
      locale: locale ?? this.locale,
    );
  }
}
