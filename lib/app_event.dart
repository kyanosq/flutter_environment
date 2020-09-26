import 'dart:ui';
import 'system_settings.dart';

abstract class AppEvent {}

class AppStarted extends AppEvent {}

class AppDidEnterBackground extends AppEvent {}

class AppFontSizeDidChange extends AppEvent {
  final FontSize fontSize;

  AppFontSizeDidChange(this.fontSize);
}

class AppDidLogin extends AppEvent {
  final String token;

  AppDidLogin(this.token);
}

class AppDidLogout extends AppEvent {}

class AppSoundEnabledDidChange extends AppEvent {
  final bool soundEnabled;

  AppSoundEnabledDidChange(this.soundEnabled);
}

class AppLocaleDidChange extends AppEvent {
  final Locale locale;

  AppLocaleDidChange(this.locale);
}
