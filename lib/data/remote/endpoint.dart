
// ignore_for_file: constant_identifier_names

class Environments {
  static const String PRODUCTION = 'https://jdi.jamkridabali.co.id/jdi/api/v1';
  // static const String DEV = 'http://52.139.153.135:4002/jdi/api/v1';
  static const String DEV = 'http://188.166.210.146:4009/jdi/api/v1';

  static String currentEnvironments = Environments.DEV;

  static setEnvironment(String value) => currentEnvironments = value;

  static String getEnvironments() => currentEnvironments;
}

class BaseUrl {
  static String baseUrl = Environments.getEnvironments();
  
  // Auth
  static String login = "$baseUrl/auth/login";
  static String refreshToken = "$baseUrl/auth/refresh";

  /// Master Data
  static String clusters = "$baseUrl/clusters?active=1";
  static String zones = "$baseUrl/zones?active=1";
  static String employees = "$baseUrl/employees?active=1";
  static String employeesAll = "$baseUrl/all-employees";
  static String employeesDetail = "$baseUrl/employees/";
  static String cgo = "$baseUrl/employees/cgo?active=1";
  static String cgoDetail = "$baseUrl/employees/cgo/";
  static String coordcgo = "$baseUrl/employees/coordcgo";
  static String marketing = "$baseUrl/employees/marketing?active=1";
  static String partners = "$baseUrl/partners";
  static String production = "$baseUrl/production";
  static String partnersPKS({int? partnerID}) 
    => "$baseUrl/partners/${partnerID.toString()}/pks";

  // Dashboard Summary
  static String dashboard = "$baseUrl/activities/summary";

  // Activity
  static String rencana = "$baseUrl/activities/plans";
  static String realisasi = "$baseUrl/activities/done";
  static String kunjunganLain = "$baseUrl/activities/other";

  // Leaves [CGO]
  static String sickLeave = "$baseUrl/leaves/sick/";
  static String generalLeave = "$baseUrl/leaves/general/";
  static String officeLeave = "$baseUrl/leaves/office/";

  // Leaves Approval
  static String approvalGeneralLeave = "$baseUrl/leaves/approval/general";
  static String approvalOfficeLeave = "$baseUrl/leaves/approval/office";

  // File Storage
  static String fileUpload = "$baseUrl/file/upload";
  static String static = Environments.getEnvironments() == Environments.DEV
    ? "http://188.166.210.146:4009/jdi/api/static/"
    : "https://jdi.jamkridabali.co.id/jdi/api/static/";
  static String downloadFile = "$baseUrl/file/download/";

  // misc
  static String notification = "$baseUrl/notifications";

  // SIMT
  static String simulasiPK = "$baseUrl/simt/simulasi-bpk";
  static String produkPenjaminan = "$baseUrl/simt/products";
  static String manfaatPenjaminan = "$baseUrl/simt/benefits";
  static String objekPenjaminan = "$baseUrl/simt/objects";
  static String jenisLembaga = "$baseUrl/simt/instances";
  static String jenisKantor = "$baseUrl/simt/offices";

  // assignment
  static String pemberiTugas = "$baseUrl/assignments/assigner";
  static String detailPemberiTugas = "$baseUrl/assignments/assigner/";
  static String tambahPemberiTugas = "$baseUrl/assignments/assigner";
  static String updatePemberiTugas = "$baseUrl/assignments/assigner/";
  static String validatePemberiTugas = "$baseUrl/assignments/assigner/";
  static String penerimaTugas = "$baseUrl/assignments/assignee";
  static String detailPenerimaTugas = "$baseUrl/assignments/assignee/";
  static String updatePenerimaTugas = "$baseUrl/assignments/assignee/";
}