// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Environment _$EnvironmentFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['baseUrl'], disallowNullValues: const ['baseUrl']);
  return Environment(
    name: json['name'] as String,
    baseUrl: json['baseUrl'] as String,
    isDebug: json['isDebug'] as bool,
    logMode: _$enumDecodeNullable(_$LogModeEnumMap, json['logMode']),
  );
}

Map<String, dynamic> _$EnvironmentToJson(Environment instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('baseUrl', instance.baseUrl);
  val['isDebug'] = instance.isDebug;
  val['logMode'] = _$LogModeEnumMap[instance.logMode];
  return val;
}

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

const _$LogModeEnumMap = {
  LogMode.none: 'none',
  LogMode.normal: 'normal',
  LogMode.verbose: 'verbose',
};
