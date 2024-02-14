import 'package:backoffice_tpt_app/feature/category/category_binding.dart';
import 'package:backoffice_tpt_app/feature/category/category_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_financial/dashboard_financial_binding.dart';
import 'package:backoffice_tpt_app/feature/dashboard_financial/dashboard_financial_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_forecasting/dashboard_forecasting_binding.dart';
import 'package:backoffice_tpt_app/feature/dashboard_forecasting/dashboard_forecasting_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_transaction/dashboard_transaction_binding.dart';
import 'package:backoffice_tpt_app/feature/dashboard_transaction/dashboard_transaction_page.dart';
import 'package:backoffice_tpt_app/feature/home/home_binding.dart';
import 'package:backoffice_tpt_app/feature/product/product_binding.dart';
import 'package:backoffice_tpt_app/feature/product/product_page.dart';
import 'package:backoffice_tpt_app/feature/report_financial/report_financial_binding.dart';
import 'package:backoffice_tpt_app/feature/report_financial/report_financial_page.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/add_purchase_binding.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/add_purchase_page.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_binding.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_page.dart';
import 'package:backoffice_tpt_app/feature/report_sale/report_sale_binding.dart';
import 'package:backoffice_tpt_app/feature/report_sale/report_sale_page.dart';
import 'package:backoffice_tpt_app/feature/setting/setting_binding.dart';
import 'package:backoffice_tpt_app/feature/supplier/supplier_binding.dart';
import 'package:backoffice_tpt_app/feature/supplier/supplier_page.dart';
import 'package:backoffice_tpt_app/feature/user/user_binding.dart';
import 'package:backoffice_tpt_app/feature/user/user_page.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/main/main_binding.dart';
import 'package:backoffice_tpt_app/feature/main/main_page.dart';
import 'package:backoffice_tpt_app/feature/home/home_page.dart';
import 'package:backoffice_tpt_app/feature/setting/setting_page.dart';
import '/feature/loader/loading_page.dart';
import '/feature/login/login_binding.dart';
import '/feature/login/login_page.dart';

import 'page_names.dart';

class PageRoutes {
  static final sideMenuBindings = [
    HomeBinding(),
    SettingBinding(),
    ProductBinding(),
    CategoryBinding(),
    SupplierBinding(),
    UserBinding(),
    SaleReportBinding(),
    PurchaseReportBinding(),
    FinancialReportBinding(),
    TransactionDashboardBinding(),
    FinancialDashboardBinding(),
    ForecastingDashboardBinding(),
  ];

  static final pages = [
    GetPage(
      name: PageName.LOADER,
      page: () => const LoadingPage(),
    ),
    GetPage(
      name: PageName.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: PageName.MAIN,
      page: () => const MainPage(),
      binding: MainBinding()
    ),
    GetPage(
      name: PageName.HOME,
      page: () => const HomePage(),
      binding: HomeBinding()
    ),
    GetPage(
      name: PageName.SETTING,
      page: () => const SettingPage(),
      binding: SettingBinding()
    ),
    GetPage(
      name: PageName.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductBinding()
    ),
    GetPage(
      name: PageName.CATEGORY,
      page: () => const CategoryPage(),
      binding: CategoryBinding()
    ),
    GetPage(
      name: PageName.SUPPLIER,
      page: () => const SupplierPage(),
      binding: SupplierBinding()
    ),
    GetPage(
      name: PageName.USER,
      page: () => const UserPage(),
      binding: UserBinding()
    ),
    GetPage(
      name: PageName.REPORT_SALE,
      page: () => const SaleReportPage(),
      binding: SaleReportBinding()
    ),
    GetPage(
      name: PageName.REPORT_PURCHASE,
      page: () => const PurchaseReportPage(),
      binding: PurchaseReportBinding()
    ),
    GetPage(
      name: PageName.ADD_REPORT_PURCHASE,
      page: () => const AddPurchaseReportPage(),
      binding: AddPurchaseReportBinding()
    ),
    GetPage(
      name: PageName.REPORT_FINANCIAL,
      page: () => const FinancialReportPage(),
      binding: FinancialReportBinding()
    ),
    GetPage(
      name: PageName.DASHBOARD_TRANSACTION,
      page: () => const TransactionDashboardPage(),
      binding: TransactionDashboardBinding()
    ),
    GetPage(
      name: PageName.DASHBOARD_FINANCIAL,
      page: () => const FinancialDashboardPage(),
      binding: FinancialDashboardBinding()
    ),
    GetPage(
      name: PageName.DASHBOARD_FORECASTING,
      page: () => const ForecastingDashboardPage(),
      binding: ForecastingDashboardBinding()
    ),
  ];
}
