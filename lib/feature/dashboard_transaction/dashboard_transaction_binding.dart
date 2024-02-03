import 'package:backoffice_tpt_app/feature/dashboard_transaction/dashboard_transaction_controller.dart';
import 'package:get/get.dart';

class TransactionDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDashboardController>(
      () => TransactionDashboardController(),
    );
  }
}