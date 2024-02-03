import 'package:backoffice_tpt_app/firebase_options.dart';
import 'package:backoffice_tpt_app/routes/page_routes.dart';
import 'package:backoffice_tpt_app/utills/helper/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/local/storage/storage_constants.dart';
import 'feature/auth/auth_controller.dart';

class Initializer {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
      );
      _initScreenPreference();
      await GetStorage.init(StorageName.STORAGE_NAME);
      await Get.putAsync<FlutterSecureStorage>(() async {
        return const FlutterSecureStorage();
      });
      Get.put<AuthController>(AuthController());
      Utils.initializedSideMenu(bindings: PageRoutes.sideMenuBindings);
    } catch (err) {
      rethrow;
    }
  }

  // static Future<void> initHive() async {
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   await Hive.initFlutter(dir.path);
  //   // HiveAdapters().registerAdapter();
  //   // await Hive.openBox<User>(HiveConstants.USERS_BOX);
  //   // await Hive.openBox<Place>(HiveConstants.PLACES);
  // }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
