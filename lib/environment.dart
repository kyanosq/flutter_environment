import 'http.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'environment.g.dart';

/// 是否生产环境
const bool inProduction = const bool.fromEnvironment("dart.vm.product");

///环境变量设置
@JsonSerializable()
class Environment extends Equatable {
  final String name;

  @JsonKey(disallowNullValue: true, required: true)
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

  factory Environment.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);

  @override
  List<Object> get props => [baseUrl, isDebug, logMode];
}
