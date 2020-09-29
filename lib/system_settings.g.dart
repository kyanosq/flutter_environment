// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemSettings _$SystemSettingsFromJson(Map<String, dynamic> json) {
  return SystemSettings(
    soundEnabled: json['soundEnabled'] as bool,
    videoAutoPlayMode: _$enumDecodeNullable(
        _$VideoAutoPlayModeEnumMap, json['videoAutoPlayMode']),
    fontSize: _$enumDecodeNullable(_$FontSizeEnumMap, json['fontSize']),
    language: json['language'] == null
        ? null
        : Language.fromJson(json['language'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SystemSettingsToJson(SystemSettings instance) =>
    <String, dynamic>{
      'soundEnabled': instance.soundEnabled,
      'videoAutoPlayMode':
          _$VideoAutoPlayModeEnumMap[instance.videoAutoPlayMode],
      'fontSize': _$FontSizeEnumMap[instance.fontSize],
      'language': instance.language?.toJson(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$VideoAutoPlayModeEnumMap = {
  VideoAutoPlayMode.none: 'none',
  VideoAutoPlayMode.wifi: 'wifi',
  VideoAutoPlayMode.all: 'all',
};

const _$FontSizeEnumMap = {
  FontSize.normal: 'normal',
  FontSize.large: 'large',
  FontSize.veryLarge: 'veryLarge',
};
