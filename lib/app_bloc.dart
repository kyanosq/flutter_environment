import 'package:environment/environment.dart';
import 'package:environment/system_settings.dart';

import 'app_repository.dart';
import 'service_provider.dart';
import 'app_event.dart';
import 'app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  ServiceProviderState serviceProvider;
  AppRepository appRepository = AppRepository();

  AppBloc(this.serviceProvider) : super(AppUninitialized());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStarted && state is AppUninitialized) {
      yield* _mapAppStartedToState();
    }
    if (event is AppDidEnterBackground) {}
    if (event is AppFontSizeDidChange) {}
    if (event is AppLocaleDidChange) {}
    if (event is AppSoundEnabledDidChange) {}
    if (event is AppDidLogin) {
      yield* _mapAppLoginToState(event);
    }
    if (event is AppDidLogout) {
      yield* _mapAppLogoutToState();
    }
  }

  Stream<AppState> _mapAppLoginToState(AppDidLogin event) async* {
    if (state is AppInitialized) {
      final newState = (state as AppInitialized).update(token: event.token);
      serviceProvider.config(newState);
      appRepository.saveState(newState);
      yield newState;
    }
  }

  Stream<AppState> _mapAppLogoutToState() async* {
    if (state is AppInitialized) {
      final newState = (state as AppInitialized).update(token: '');
      serviceProvider.config(newState);
      appRepository.saveState(newState);
      yield newState;
    }
  }

  ///  启动后加载配置文件, 读取缓存等数据, 如果是生产环境, 直接使用默认设置即可
  Stream<AppState> _mapAppStartedToState() async* {
    AppInitialized state = await appRepository.restoreFromCache();
    if (state != null && inProduction) {
      state.update(environment: serviceProvider.widget.defaultEnvironment);
    }
    if (state == null) {
      final environment = serviceProvider.widget.defaultEnvironment;
      final settings = SystemSettings.empty();
      state = AppInitialized(
          environment: environment, systemSettings: settings, token: '');
    }
    serviceProvider.config(state); //更新设置
    //完成后返回app真正的初始状态
    yield state;
  }
}
