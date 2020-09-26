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
    print(event);
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
      yield (state as AppInitialized).update(token: event.token);
    }
  }

  Stream<AppState> _mapAppLogoutToState() async* {
    if (state is AppInitialized) {
      yield (state as AppInitialized).update(token: '');
    }
  }

  ///  启动后加载配置文件, 读取缓存等数据
  Stream<AppState> _mapAppStartedToState() async* {
    AppInitialized state = await appRepository.restoreFromCache();

    /// 初始化
    serviceProvider.config(state);
    //完成后返回app真正的初始状态
    yield state;
  }
}
