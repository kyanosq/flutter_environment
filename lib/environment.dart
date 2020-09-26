import 'dart:convert';
import 'http.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

const bool inProduction = const bool.fromEnvironment("dart.vm.product");

class Environment {
  final String name;
  final String baseUrl;
  final bool isDebug;
  final LogMode logMode;
  final bool isProxy;

  static Future<Environment> initial() async {
    try {
      Environment environment = await loadFromJson() ?? Environment();
      return environment;
    } catch (e) {
      return Environment();
    }
  }

  static Future<Environment> loadFromJson() {
    final path = inProduction ? 'lib/env/env_pro.json' : 'lib/env/env_dev.json';
    return rootBundle.loadStructuredData<Environment>(path, (jsonStr) async {
      final environmentLoader = Environment.fromJson(json.decode(jsonStr));
      return environmentLoader;
    });
  }

  const Environment(
      {this.name, this.baseUrl, bool isDebug, LogMode logMode, bool isProxy})
      : this.isDebug = isDebug ?? false,
        this.logMode = logMode ?? LogMode.none,
        this.isProxy = isProxy ?? false;

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
        name: json['name'] as String,
        baseUrl: json['baseUrl'] as String,
        isDebug: json['isDebug'] as bool,
        logMode: json['logMode'] as LogMode,
        isProxy: json['isProxy'] as bool,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'baseUrl': baseUrl,
      'isDebug': isDebug,
      'logMode': logMode,
      'isProxy': isProxy,
    };
  }
}
