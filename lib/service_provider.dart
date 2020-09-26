import 'app_state.dart';
import 'http.dart';
import 'package:flutter/material.dart';

// class ServiceProviders with ChangeNotifier {
//
//    HTTPServiceType _httpService;
//    HTTPServiceType get httpService => _httpService;
//
//    void config(AppInitialized state) {
//
//
//      notifyListeners();
//    }
//
// }

/// 提供基础功能服务, 如HTTP请求, 键值存储等
class ServiceProvider extends StatefulWidget {
  final Widget Function(ServiceProviderState) create;

  const ServiceProvider({Key key, @required this.create}) : super(key: key);

  @override
  ServiceProviderState createState() => ServiceProviderState();

  static ServiceProviderState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ServiceProvider>().data;
  }
}

class ServiceProviderState extends State<ServiceProvider> {
  HTTPServiceType httpService;

  void config(AppInitialized state) {
    if (httpService == null) {
      httpService = HTTPService(
          locale: Locale('en_US'), baseUrl: state.environment.baseUrl);
    } else {
      httpService.baseUrl = state.environment.baseUrl;
      httpService.locale = Locale('en_US');
    }
    // print(state.environment.baseUrl);
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
    return true;
  }
}
