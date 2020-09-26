// import 'dart:async';
//
// import 'package:connectivity/connectivity.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'connectivity.dart';
// import 'package:rxdart/rxdart.dart';
//
// //字号//声音大小//验证进入
// class UserDefaultsService {
//
//   SharedPreferences _sharedPreferences;
//   ConnectivityService _connectivityService;
//
//   static const soundSettingKey = 'soundSettingKey';
//   static const fontSizeSettingKey = 'fontSizeSettingKey';
//   static const videoAutoPlaySettingKey = 'videoAutoPlaySettingKey';
//
//   ConnectivityResult _currentConnectivity;
//   StreamSubscription _connectivityChangeSubscription;
//
//   final _videosAutoPlayEnabledChangeSubject = BehaviorSubject<bool>();
//   bool _videosAutoPlayAreEnabled = false;
//   Stream<bool> get videosAutoPlayAreEnabledChange =>
//       _videosAutoPlayEnabledChangeSubject.stream;
//
//   // Bootstrapped after connectivity service is given in the provider
//   void bootstrap() async {
//     _currentConnectivity = _connectivityService.getConnectivity();
//     // _refreshConnectivityDependentSettings();
//
//     _connectivityChangeSubscription =
//         _connectivityService.onConnectivityChange(_onConnectivityChange);
//
//     // HashtagsDisplaySetting hashtagsDisplaySetting = await getHashtagsDisplaySetting();
//     // _hashtagsDisplaySettingChangeSubject.add(hashtagsDisplaySetting);
//   }
//
//   void _onConnectivityChange(ConnectivityResult newConnectivity) {
//     _currentConnectivity = newConnectivity;
//     // _refreshConnectivityDependentSettings();
//   }
//
//   void setLocalizationService(LocalizationService localizationService) {
//     // _localizationService = localizationService;
//   }
//
//   void setConnectivityService(ConnectivityService connectivityService) {
//     _connectivityService = connectivityService;
//   }
//
//   void dispose() {
//     _connectivityChangeSubscription?.cancel();
//     _linkPreviewsEnabledChangeSubject.close();
//     _videosSoundSettingChangeSubject.close();
//     _videosAutoPlaySettingChangeSubject.close();
//     _videosAutoPlayEnabledChangeSubject.close();
//     _hashtagsDisplaySettingChangeSubject.close();
//
//   }
// }