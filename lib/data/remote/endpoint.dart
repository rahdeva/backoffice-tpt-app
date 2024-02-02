
// ignore_for_file: constant_identifier_names

class Environments {
  static const String PRODUCTION = '';
  static const String DEV = 'http://188.166.210.146:4009/jdi/api/v1';
  static const String LOCAL = 'http://192.168.1.14:4000/api/v1';

  static String currentEnvironments = Environments.DEV;

  static setEnvironment(String value) => currentEnvironments = value;

  static String getEnvironments() => currentEnvironments;

  static String getEnvironmentsLocal() => Environments.LOCAL;
}

class BaseUrlLocal {
  static String baseUrlLocal = Environments.getEnvironmentsLocal();

  // User
  static String user = "$baseUrlLocal/users";
  static String userByUID({String? uid}) 
    => "$baseUrlLocal/users/uid/$uid";

  // Product
  static String product = "$baseUrlLocal/products";

  // Sale
  static String sale = "$baseUrlLocal/sales";
  static String saleDetail({int? saleID}) 
    => "$baseUrlLocal/users/uid/$saleID";
}

class BaseUrl {
  static String baseUrl = Environments.getEnvironments();
  
  // Auth
  static String login = "$baseUrl/auth/login";
  static String refreshToken = "$baseUrl/auth/refresh";
}