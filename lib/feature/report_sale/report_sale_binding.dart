import 'package:backoffice_tpt_app/feature/report_sale/report_sale_controller.dart';
import 'package:get/get.dart';

class SaleReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleReportController>(
      () => SaleReportController(),
    );
  }
}