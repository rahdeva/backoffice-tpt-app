import 'package:backoffice_tpt_app/feature/category/category_controller.dart';
import 'package:backoffice_tpt_app/feature/dashboard_financial/dashboard_financial_controller.dart';
import 'package:backoffice_tpt_app/feature/dashboard_forecasting/dashboard_forecasting_controller.dart';
import 'package:backoffice_tpt_app/feature/dashboard_transaction/dashboard_transaction_controller.dart';
import 'package:backoffice_tpt_app/feature/product/product_controller.dart';
import 'package:backoffice_tpt_app/feature/report_financial/report_financial_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_sale/report_sale_controller.dart';
import 'package:backoffice_tpt_app/feature/supplier/supplier_controller.dart';
import 'package:backoffice_tpt_app/feature/user/user_controller.dart';
import 'package:get/get.dart';
import 'main_controller.dart';
import '/feature/home/home_controller.dart';
import '../setting/setting_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<CategoryController>(() => CategoryController(), fenix: true);
    Get.lazyPut<SupplierController>(() => SupplierController(), fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut<SaleReportController>(() => SaleReportController(), fenix: true);
    Get.lazyPut<PurchaseReportController>(() => PurchaseReportController(), fenix: true);
    Get.lazyPut<FinancialReportController>(() => FinancialReportController(), fenix: true);
    Get.lazyPut<TransactionDashboardController>(() => TransactionDashboardController(), fenix: true);
    Get.lazyPut<FinancialDashboardController>(() => FinancialDashboardController(), fenix: true);
    Get.lazyPut<ForecastingDashboardController>(() => ForecastingDashboardController(), fenix: true);
  }
}