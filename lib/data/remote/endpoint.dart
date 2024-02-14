
// ignore_for_file: constant_identifier_names

class Environments {
  static const String PRODUCTION = '';
  static const String DEV = 'http://188.166.210.146:4009/jdi/api/v1';
  static const String LOCAL = 'http://192.168.1.16:4000/api/v1';
  // static const String LOCAL = 'http://192.168.43.93:4000/api/v1';

  static String currentEnvironments = Environments.DEV;

  static setEnvironment(String value) => currentEnvironments = value;

  static String getEnvironments() => currentEnvironments;

  static String getEnvironmentsLocal() => Environments.LOCAL;
}

class BaseUrlLocal {
  static String baseUrlLocal = Environments.getEnvironmentsLocal();

  // User
  static String user = "$baseUrlLocal/users";
  static String userByUID({String? uid}) => "$baseUrlLocal/users/uid/$uid";
  static String userByID({int? userId}) => "$baseUrlLocal/users/$userId";
  static String deleteUser({int? userId}) => "$baseUrlLocal/users/$userId";

  // Product
  static String product = "$baseUrlLocal/products";
  static String productByID({int? productId}) => "$baseUrlLocal/products/$productId";
  static String deleteProduct({int? productId}) => "$baseUrlLocal/products/$productId";

  // Category
  static String category = "$baseUrlLocal/categories";
  static String categoryByID({int? categoryId}) => "$baseUrlLocal/categories/$categoryId";
  static String deleteCategory({int? categoryId}) => "$baseUrlLocal/categories/$categoryId";

  // Supplier
  static String supplier = "$baseUrlLocal/suppliers";
  static String supplierByID({int? supplierId}) => "$baseUrlLocal/suppliers/$supplierId";
  static String deleteSupplier({int? supplierId}) => "$baseUrlLocal/suppliers/$supplierId";

  // Roles
  static String role = "$baseUrlLocal/roles";
  static String roleByID({int? roleId}) => "$baseUrlLocal/roles/$roleId";
  static String deleteRole({int? roleId}) => "$baseUrlLocal/roles/$roleId";

  // Sale
  static String sale = "$baseUrlLocal/sales";
  static String saleByID({int? saleID}) => "$baseUrlLocal/sales/$saleID";
  static String saleDetail({int? saleID}) => "$baseUrlLocal/sales/detail/$saleID";
  static String deleteSale({int? saleID}) => "$baseUrlLocal/sales/$saleID";

  // Purchase
  static String purchase = "$baseUrlLocal/purchases";
  static String purchaseByID({int? purchaseID}) => "$baseUrlLocal/purchases/$purchaseID";
  static String purchaseDetail({int? purchaseID}) => "$baseUrlLocal/purchases/detail/$purchaseID";
  static String deletePurchase({int? purchaseID}) => "$baseUrlLocal/purchases/$purchaseID";

  // Financial
  static String financial = "$baseUrlLocal/financials";
  static String financialBalance = "$baseUrlLocal/financials/balance/";
  static String financialByID({int? financialID}) => "$baseUrlLocal/financials/$financialID";
  static String financialDetail({int? financialID}) => "$baseUrlLocal/financials/detail/$financialID";
  static String deleteFinancial({int? financialID}) => "$baseUrlLocal/financials/$financialID";

  // Home
  static String home = "$baseUrlLocal/home";

  // Dashboard

}

class BaseUrl {
  static String baseUrl = Environments.getEnvironments();
  
  // Auth
  static String login = "$baseUrl/auth/login";
  static String refreshToken = "$baseUrl/auth/refresh";

  // User
  static String user = "$baseUrl/users";
  static String userByUID({String? uid}) => "$baseUrl/users/uid/$uid";
  static String userByID({int? userId}) => "$baseUrl/users/$userId";
  static String deleteUser({int? userId}) => "$baseUrl/users/$userId";

  // Product
  static String product = "$baseUrl/products";
  static String productByID({int? productId}) => "$baseUrl/products/$productId";
  static String deleteProduct({int? productId}) => "$baseUrl/products/$productId";

  // Category
  static String category = "$baseUrl/categories";
  static String categoryByID({int? categoryId}) => "$baseUrl/categories/$categoryId";
  static String deleteCategory({int? categoryId}) => "$baseUrl/categories/$categoryId";

  // Supplier
  static String supplier = "$baseUrl/suppliers";
  static String supplierByID({int? supplierId}) => "$baseUrl/suppliers/$supplierId";
  static String deleteSupplier({int? supplierId}) => "$baseUrl/suppliers/$supplierId";

  // Roles
  static String role = "$baseUrl/roles";
  static String roleByID({int? roleId}) => "$baseUrl/roles/$roleId";
  static String deleteRole({int? roleId}) => "$baseUrl/roles/$roleId";

  // Sale
  static String sale = "$baseUrl/sales";
  static String saleByID({int? saleID}) => "$baseUrl/sales/$saleID";
  static String saleDetail({int? saleID}) => "$baseUrl/sales/detail/$saleID";
  static String deleteSale({int? saleID}) => "$baseUrl/sales/$saleID";

  // Purchase
  static String purchase = "$baseUrl/purchases";
  static String purchaseByID({int? purchaseID}) => "$baseUrl/purchases/$purchaseID";
  static String purchaseDetail({int? purchaseID}) => "$baseUrl/purchases/detail/$purchaseID";
  static String deletePurchase({int? purchaseID}) => "$baseUrl/purchases/$purchaseID";

  // Financial
  static String financial = "$baseUrl/financials";
  static String financialBalance = "$baseUrl/financials/balance/";
  static String financialByID({int? financialID}) => "$baseUrl/financials/$financialID";
  static String financialDetail({int? financialID}) => "$baseUrl/financials/detail/$financialID";
  static String deleteFinancial({int? financialID}) => "$baseUrl/financials/$financialID";

  // Home
  static String home = "$baseUrl/home";

  // Dashboard
  
}