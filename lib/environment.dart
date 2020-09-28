import 'dart:convert';
import 'http.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;

/// 是否生产环境
const bool inProduction = const bool.fromEnvironment("dart.vm.product");

///环境变量设置
class Environment {
  final String name;
  final String baseUrl;
  final bool isDebug;
  final LogMode logMode;

  const Environment(
      {@required this.name,
      @required this.baseUrl,
      bool isDebug,
      LogMode logMode})
      : this.isDebug = isDebug ?? false,
        this.logMode = logMode ?? LogMode.none;

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
        name: json['name'] as String,
        baseUrl: json['baseUrl'] as String,
        isDebug: json['isDebug'] as bool,
        logMode: json['logMode'] as LogMode,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'baseUrl': baseUrl,
      'isDebug': isDebug,
      'logMode': logMode,
    };
  }
}
