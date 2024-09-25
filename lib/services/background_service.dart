// services/background_service.dart
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

void initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
    ),
  );

  service.startService();
}

void onStart(ServiceInstance service) async {
  _setupForegroundNotification(service);
  _listenForEvents(service);

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
}

void _setupForegroundNotification(ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "백그라운드 서비스",
      content: "서비스가 실행 중입니다.",
    );
  }
}

void _listenForEvents(ServiceInstance service) {
  service.on('test').listen((event) {
    print('백그라운드 서비스가 실행 중입니다.');
  });
}

// iOS 백그라운드 작업을 처리하는 함수
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   return true;
// }
