import 'package:backoffice_tpt_app/feature/category/category_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_financial/dashboard_financial_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_forecasting/dashboard_forecasting_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_transaction/dashboard_transaction_page.dart';
import 'package:backoffice_tpt_app/feature/product/product_page.dart';
import 'package:backoffice_tpt_app/feature/report_financial/report_financial_page.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_page.dart';
import 'package:backoffice_tpt_app/feature/report_sale/report_sale_page.dart';
import 'package:backoffice_tpt_app/feature/supplier/supplier_page.dart';
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
    ),
    GetPage(
      name: PageName.SETTING,
      page: () => const SettingPage(),
    ),
    GetPage(
      name: PageName.PRODUCT,
      page: () => const ProductPage(),
    ),
    GetPage(
      name: PageName.CATEGORY,
      page: () => const CategoryPage(),
    ),
    GetPage(
      name: PageName.SUPPLIER,
      page: () => const SupplierPage(),
    ),
    GetPage(
      name: PageName.USER,
      page: () => const UserPage(),
    ),
    GetPage(
      name: PageName.REPORT_SALE,
      page: () => const SaleReportPage(),
    ),
    GetPage(
      name: PageName.REPORT_PURCHASE,
      page: () => const PurchaseReportPage(),
    ),
    GetPage(
      name: PageName.REPORT_FINANCIAL,
      page: () => const FinancialReportPage(),
    ),
    GetPage(
      name: PageName.DASHBOARD_TRANSACTION,
      page: () => const TransactionDashboardPage(),
    ),
    GetPage(
      name: PageName.DASHBOARD_FINANCIAL,
      page: () => const FinancialDashboardPage(),
    ),
    GetPage(
      name: PageName.DASHBOARD_FORECASTING,
      page: () => const ForecastingDashboardPage(),
    ),
  ];
}
