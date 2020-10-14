import 'package:environment/environment.dart';
import 'package:environment/service_center.dart';
import 'package:environment/settings.dart';
import 'package:get_it/get_it.dart';

import 'app_repository.dart';
import 'app_event.dart';
import 'app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppRepository appRepository = AppRepository();

  AppBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStarted) {
      // yield* _mapAppStartedToState();
    }
    // GetIt.instance
    if (event is AppDidEnterBackground) {}
    if (event is FontScaleModeChanged) {}
    if (event is AppLocaleChanged) {}
    if (event is AppSoundEnabledChanged) {}
    if (event is AppLoggedIn) {
      yield* _mapAppLoginToState(event);
    }
    if (event is AppLoggedOut) {
      yield* _mapAppLogoutToState();
    }
  }

  Stream<AppState> _mapAppLoginToState(AppLoggedIn event) async* {
    final newState = state.update(token: event.token);
    GetIt.instance.get<ServiceCenter>().update(newState);
    AppRepository.saveState(newState);
    yield newState;
  }

  Stream<AppState> _mapAppLogoutToState() async* {
    final newState = state.update(token: '');
    GetIt.instance.get<ServiceCenter>().update(newState);
    AppRepository.saveState(newState);
    yield newState;
  }
}
