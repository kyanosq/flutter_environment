import 'package:environment/environment.dart';

import 'app_state.dart';
import 'http.dart';
import 'package:flutter/material.dart';

/// 提供基础功能服务, 如HTTP请求, 键值存储等
class ServiceProvider extends StatefulWidget {
  final Widget Function(ServiceProviderState) create;

  /// 默认的环境, 如果未从缓存获取到, 则使用该设置
  final Environment defaultEnvironment;

  const ServiceProvider(
      {Key key, @required this.defaultEnvironment, @required this.create})
      : super(key: key);

  @override
  ServiceProviderState createState() => ServiceProviderState();

  static ServiceProviderState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ServiceProvider>().data;
  }
}

class ServiceProviderState extends State<ServiceProvider> {
  HTTPServiceType httpService = HTTPService(
      locale: Locale('en_US'), baseUrl: '', logMode: LogMode.none, token: '');

  void config(AppInitialized state) {
    httpService.baseUrl = state.environment.baseUrl;
    httpService.logMode = state.environment.logMode;
    httpService.locale = Locale('en_US');
    httpService.token = state.token;
  }

  @override
  Widget build(BuildContext context) {
    return _ServiceProvider(
      data: this,
      child: widget.create(this),
    );
  }

  @override
  void initState() {
    super.initState();

    _initAsyncState();
  }

  void _initAsyncState() {}
}

class _ServiceProvider extends InheritedWidget {
  final ServiceProviderState data;

  _ServiceProvider({Key key, this.data, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_ServiceProvider old) {
    return false;
  }
}
