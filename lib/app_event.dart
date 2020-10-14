import 'dart:ui';
import 'settings.dart';

abstract class AppEvent {}

class AppStarted extends AppEvent {}

class AppDidEnterBackground extends AppEvent {}

class FontScaleModeChanged extends AppEvent {
  final FontScaleMode fontScaleMode;

  FontScaleModeChanged(this.fontScaleMode);
}

class AppLoggedIn extends AppEvent {
  final String token;

  AppLoggedIn(this.token);
}

class AppLoggedOut extends AppEvent {}

class AppSoundEnabledChanged extends AppEvent {
  final bool soundEnabled;

  AppSoundEnabledChanged(this.soundEnabled);
}

class AppLocaleChanged extends AppEvent {
  final Locale locale;

  AppLocaleChanged(this.locale);
}
