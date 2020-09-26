import 'language.dart';

enum FontSize { normal, large, veryLarge }
enum VideoAutoPlayMode { none, wifi, all }

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

  factory SystemSettings.fromJson(Map<String, dynamic> json) => SystemSettings(
        soundEnabled: json['soundEnabled'] as bool,
        videoAutoPlayMode: json['videoAutoPlayMode'] as VideoAutoPlayMode,
        fontSize: json['fontSize'] as FontSize,
        language: json['language'] as Language,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'soundEnabled': soundEnabled,
      'videoAutoPlayMode': videoAutoPlayMode,
      'fontSize': fontSize,
      'language': language,
    };
  }

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
