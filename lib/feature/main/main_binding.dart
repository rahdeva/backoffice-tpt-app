import 'package:get/get.dart';
import '../history/history_controller.dart';
import 'main_controller.dart';
import '/feature/home/home_controller.dart';
import '../setting/setting_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
  }
}