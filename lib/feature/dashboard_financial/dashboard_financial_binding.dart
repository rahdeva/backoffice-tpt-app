import 'package:backoffice_tpt_app/feature/dashboard_financial/dashboard_financial_controller.dart';
import 'package:get/get.dart';

class FinancialDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinancialDashboardController>(
      () => FinancialDashboardController(),
    );
  }
}