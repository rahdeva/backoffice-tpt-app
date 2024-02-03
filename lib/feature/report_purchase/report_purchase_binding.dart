import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:get/get.dart';

class PurchaseReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseReportController>(
      () => PurchaseReportController(),
    );
  }
}