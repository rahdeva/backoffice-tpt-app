// import 'package:emc_mobile_flutter/feature/auth/auth_controller.dart';
// import 'package:emc_mobile_flutter/utills/helper/firebase/RemoteConfig/remote_config_params.dart';
// import 'package:emc_mobile_flutter/utills/helper/firebase/RemoteConfig/remote_config_service.dart';
// import 'package:emc_mobile_flutter/utills/helper/firebase/on_update_checker.dart';
// import 'package:emc_mobile_flutter/utills/widget/smdialog.dart';
// import 'package:get/get.dart';

// ///
// /// Created by alfianhpratama on 13/01/23
// ///

// class LoaderController extends GetxController {
//   @override
//   void onInit() async {
//     super.onInit();
//     var rcf = RemoteConfigService.getInstance();
//     Map<String, dynamic> update = await OnUpdateChecker.checkNewApp(rcf);
//     if (update.isNotEmpty) {
//       if (update[OnUpdateChecker.FORCE_UPDATE] == true) {
//         SMDialog.showForceUpdateDialog(
//           desc: rcf.getStringValue(RemoteConfigParams.MESSAGE_FORCE),
//           onYes: () async => await OnUpdateChecker.launchStore(),
//           onCancel: Get.back,
//         );
//       } else if (update[OnUpdateChecker.NORMAL_UPDATE] == true) {
//         SMDialog.showUpdateDialog(
//           desc: rcf.getStringValue(RemoteConfigParams.MESSAGE_INFO),
//           onYes: () async {
//             await OnUpdateChecker.launchStore();
//             Get.put<AuthController>(AuthController(), permanent: true);
//           },
//           onCancel: () => Get.put<AuthController>(AuthController(), permanent: true),
//         );
//       }
//     } else {
//       Get.put<AuthController>(AuthController(), permanent: true);
//     }
//   }
// }

// class LoadingBinding implements Bindings {
//   @override
//   void dependencies() => Get.lazyPut(() => LoaderController());
// }
