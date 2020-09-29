import 'language.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system_settings.g.dart';

enum FontSize { normal, large, veryLarge }
enum VideoAutoPlayMode { none, wifi, all }

@JsonSerializable(explicitToJson: true)
class SystemSettings {
  final bool soundEnabled;
  final VideoAutoPlayMode videoAutoPlayMode;
  final FontSize fontSize;
  final Language language;

  const SystemSettings(
      {this.soundEnabled,
      this.videoAutoPlayMode,
      this.fontSize,
      this.language});

  SystemSettings.empty()
      : soundEnabled = false,
        videoAutoPlayMode = VideoAutoPlayMode.none,
        fontSize = FontSize.normal,
        language = Language.system;

  factory SystemSettings.fromJson(Map<String, dynamic> json) =>
      _$SystemSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SystemSettingsToJson(this);

  SystemSettings update({
    bool soundEnabled,
    VideoAutoPlayMode videoAutoPlayMode,
    FontSize fontSize,
    Language language,
  }) {
    return copyWith(
        soundEnabled: soundEnabled,
        videoAutoPlayMode: videoAutoPlayMode,
        fontSize: fontSize,
        language: language);
  }

  SystemSettings copyWith({
    bool soundEnabled,
    VideoAutoPlayMode videoAutoPlayMode,
    FontSize fontSize,
    Language language,
  }) {
    return SystemSettings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      videoAutoPlayMode: videoAutoPlayMode ?? this.videoAutoPlayMode,
      fontSize: fontSize ?? this.fontSize,
      language: language ?? this.language,
    );
  }
}
