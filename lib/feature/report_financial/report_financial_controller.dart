import 'dart:async';
import 'package:backoffice_tpt_app/feature/auth/auth_controller.dart';
import 'package:backoffice_tpt_app/model/balance.dart';
import 'package:backoffice_tpt_app/model/financial.dart';
import 'package:backoffice_tpt_app/model/financial_detail.dart';
import 'package:backoffice_tpt_app/model/financial_type.dart';
import 'package:backoffice_tpt_app/model/user.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/loading_helper.dart';
import 'package:backoffice_tpt_app/utills/helper/string_formatter.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/snackbar/snackbar_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';
import 'package:intl/intl.dart';

class FinancialReportController extends GetxController {
  final GlobalKey<FormBuilderState> searchformKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> addFinancialReportFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> editFinancialReportFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> deleteFinancialReportFormKey = GlobalKey<FormBuilderState>();
  final AuthController authController = AuthController.find;
  UserData? get user => authController.user;
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  bool isLoading = false;

  List<Financial> dataList = [];
  late Financial dataObject;

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);
  Rx<String> searchKeyword = Rx("");

  FinancialType? addfinancialTypeResult;
  FinancialType? editfinancialTypeResult;
  FinancialType? deletefinancialTypeResult;

  int balances = 0;

  @override
  void onInit() {
    getLatestBalance();
    getFinancialReports();
    super.onInit();
  }

  Future<void> refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    searchformKey.currentState?.reset();
    searchKeyword.value = "";
    tableKey.currentState?.pageTo(1);
    getLatestBalance();
    await getFinancialReports();
    update();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    getFinancialReports();
  }

  void onPageChanged(value){
    if(value == 1){
      page.value = 1;
    } else{
      int currentPage = (value / pageSize.value).ceil();
      debugPrint('Current Page: ${page.value}');
      debugPrint('Next Page: ${currentPage + 1}');
      page.value = currentPage + 1;
      loadNext.value = true;
    }
    Timer(
      const Duration(seconds: 0), 
      () => scrollController.animateTo(
        0.0, curve: Curves.easeOut, 
        duration: const Duration(milliseconds: 300)
      ),
    );  
    getFinancialReports(page: page.value);
  }
  
  // FinancialType List
  List<FinancialType>? financialTypeList = [
    FinancialType(
      typeId: 1,
      typeName: "Modal",
    ),
    FinancialType(
      typeId: 2,
      typeName: "Biaya Operasional"
    ),
    FinancialType(
      typeId: 3,
      typeName: "Biaya Lain-lain"
    ),
  ];

  FinancialType? getFinancialTypeByTypeId(int typeId) {
    return financialTypeList?.firstWhere(
      (financialType) => financialType.typeId == typeId,
    );
  }

  String getFinancialTypeNamebyTypeId(int? typeId) {
    FinancialType? financialType = getFinancialTypeByTypeId(typeId!);
    return financialType?.typeName ?? "";
  }

  // [READ] Get Balance
  void getLatestBalance() async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    BalanceResponse? financialResponse;

    try {
      final balanceData = await dio.get(
        BaseUrlLocal.financialBalance,
      );
      debugPrint('Financials: ${balanceData.data}');
      financialResponse = BalanceResponse.fromJson(balanceData.data);
      balances = financialResponse.data?.balance ?? 0;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [READ] Get All Financials
  Future<void> getFinancialReports({
    String? keyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    FinancialResponse? financialResponse;

    try {
      final financialData = await dio.get(
        "${BaseUrlLocal.financial}?keyword=${keyword ?? ""}&pageSize=${pageSize.value}&page=$page",
      );
      debugPrint('Financials: ${financialData.data}');
      financialResponse = FinancialResponse.fromJson(financialData.data);
      if(loadNext.value == true){
        dataList.addAll(financialResponse.data!.financial ?? []); 
        loadNext.value = false;
      } else{
        dataList = financialResponse.data!.financial ?? [];
      }
      totalItems.value = financialResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [CREATE] Add New Financial Report
  void addNewFinancialReport({
    required int type, 
    required DateTime financialDate, 
    required String information,
    required String cashIn, 
    required String cashOut, 
    required String balance, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getBasicDIO();
    DateTime financialDateUTC8 = financialDate.toUtc().add(const Duration(hours: 8));
    String financialDateValue = financialDateUTC8.toIso8601String();

    try {
      final financialData = await dio.post(
        BaseUrlLocal.financial,
        data: {
          "user_id" : user?.userId,
          "type" : type,
          "information" : information,
          "financial_date": financialDateValue,
          "cash_in" : StringFormatter.formatCurrencyNumber(cashIn),
          "cash_out" : StringFormatter.formatCurrencyNumber(cashOut),
          "balance" : StringFormatter.formatCurrencyNumber(balance),
        },
      );
      debugPrint('Tambah Laporan: ${financialData.data}');
      dismissLoading();
      Get.back();
      getFinancialReports();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Laporan berhasil ditambahkan.", 
        buttonText: "OK"
      );
    } on DioError catch (error) {
      dismissLoading();
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Error!",
        subtitle: "${error.response!.statusCode.toString()} - ${error.response!.statusMessage.toString()}",
      );
      debugPrint(error.toString());
    }
  }

  // [READ] Get Financial Report Detail
  Future<void> getFinancialReportDetail({
    int? financialId,
    bool? isEdit
  }) async {
    final dio = await AppDio().getDIO();
    FinancialReportDetailResponse? financialDetailResponse;

    try {
      final financialDetailData = await dio.get(
        BaseUrlLocal.financialByID(financialID: financialId)
      );
      debugPrint('Financial Detail : ${financialDetailData.data}');
      financialDetailResponse = FinancialReportDetailResponse.fromJson(financialDetailData.data);
      dataObject = financialDetailResponse.data!.financial!;
      if(isEdit == true){
        editFinancialReportFormKey.currentState!.patchValue({
          "information" : dataObject.information,
          "financial_date": dataObject.financialDate,
          "cash_in" : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.cashIn),
          "cash_out" : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.cashOut),
          "balance" : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.balance),
        });
        editfinancialTypeResult = getFinancialTypeByTypeId(dataObject.type!);
        update(['edit-financial-type-dropdown']);
      } else{
        deleteFinancialReportFormKey.currentState!.patchValue({
          "information" : dataObject.information,
          "financial_date": dataObject.financialDate,
          "cash_in" : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.cashIn),
          "cash_out" : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.cashOut),
          "balance" : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.balance),
        });
        deletefinancialTypeResult = getFinancialTypeByTypeId(dataObject.type!);
        update(['delete-financial-type-dropdown']);
      }
      update();
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
  }

  // [UPDATE] Update FinancialReport
  void updateFinancialReport({
    required int financialId, 
    required int userId, 
    required int type, 
    required DateTime financialDate,  
    required String information,
    required String cashIn, 
    required String cashOut, 
    required String balance,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();
    String financialDateValue = financialDate.toIso8601String();
    if(financialDate != dataObject.financialDate){
      DateTime financialDateUTC8 = financialDate.toUtc().add(const Duration(hours: 8));
      financialDateValue = financialDateUTC8.toIso8601String();
    }

    try {
      final financialData = await dio.put(
        BaseUrlLocal.financial,
        data: {
          "financial_id": financialId,
          "user_id" : userId,
          "type" : type,
          "information" : information,
          "financial_date": financialDateValue,
          "cash_in" : StringFormatter.formatCurrencyNumber(cashIn),
          "cash_out" : StringFormatter.formatCurrencyNumber(cashOut),
          "balance" : StringFormatter.formatCurrencyNumber(balance),
        },
      );
      debugPrint('Edit Financial: ${financialData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Laporan berhasil diperbaharui.", 
        buttonText: "OK"
      );
      await refreshPage();
    } on DioError catch (error) {
      dismissLoading();
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Error!",
        subtitle: "${error.response!.statusCode.toString()} - ${error.response!.statusMessage.toString()}",
      );
      debugPrint(error.toString());
    }
  }

  // [DELETE] Delete Financial Report
  void deleteFinancialReport({
    required int financialId, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final financialData = await dio.delete(
        BaseUrlLocal.deleteFinancial(financialID: financialId)
      );
      debugPrint('Delete Financial: ${financialData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Laporan berhasil dihapus.", 
        buttonText: "OK"
      );
      await refreshPage();
    } on DioError catch (error) {
      dismissLoading();
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Error!",
        subtitle: "${error.response!.statusCode.toString()} - ${error.response!.statusMessage.toString()}",
      );
      debugPrint(error.toString());
    }
  }
}