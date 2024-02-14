import 'dart:async';

import 'package:backoffice_tpt_app/model/purchase.dart';
import 'package:backoffice_tpt_app/model/purchase_detail.dart';
import 'package:backoffice_tpt_app/model/supplier.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/loading_helper.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/snackbar/snackbar_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';

class PurchaseReportController extends GetxController {
  final GlobalKey<FormBuilderState> searchformKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> addPurchaseReportFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> editPurchaseReportFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> deletePurchaseReportFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> searchSupplierformKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final tableDetailKey = GlobalKey<PaginatedDataTableState>();
  final tableSupplierKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  final scrollController2 = ScrollController();
  final scrollController3 = ScrollController();
  bool isLoading = false;

  List<Purchase> dataList = [];
  Purchase? purchaseDetail;
  List<PurchaseDetail> detailDataList = [];
  List<Supplier> supplierDataList = [];

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);
  
  Rx<int> detailPage = Rx(1);
  Rx<int> detailTotalItems = Rx(0);
  Rx<int> detailPageSize = Rx(8);
  Rx<bool> detailLoadNext = Rx(false);

  Rx<int> chooseSupplierPage = Rx(1);
  Rx<int> chooseSupplierTotalItems = Rx(0);
  Rx<int> chooseSupplierPageSize = Rx(8);
  Rx<bool> chooseSupplierLoadNext = Rx(false);
  Rx<String> searchSupplierKeyword = Rx("");

  @override
  void onInit() {
    getPurchasesReport();
    super.onInit();
  }

  Future<void> refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    getPurchasesReport();
    update();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    getPurchasesReport();
  }

  void onDetailRowsPerPageChanged(value){
    detailPageSize.value = value;
    detailPage.value = 1;
    detailDataList.clear();
    tableDetailKey.currentState?.pageTo(1);
    getPurchasesDetail();
  }

  void onSupplierRowsPerPageChanged(value){
    chooseSupplierPageSize.value = value;
    chooseSupplierPage.value = 1;
    supplierDataList.clear();
    tableSupplierKey.currentState?.pageTo(1);
    getAllSuppliers();
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
    getPurchasesReport(page: page.value);
  }

  void onDetailPageChanged(value){
    if(value == 1){
      detailPage.value = 1;
    } else{
      int detailCurrentPage = (value / detailPageSize.value).ceil();
      debugPrint('Current Page: ${detailPage.value}');
      debugPrint('Next Page: ${detailCurrentPage + 1}');
      detailPage.value = detailCurrentPage + 1;
      detailLoadNext.value = true;
    }
    Timer(
      const Duration(seconds: 0), 
      () => scrollController2.animateTo(
        0.0, curve: Curves.easeOut, 
        duration: const Duration(milliseconds: 300)
      ),
    );  
    getPurchasesDetail(page: detailPage.value);
  }

  void onSupplierPageChanged(value){
    if(value == 1){
      chooseSupplierPage.value = 1;
    } else{
      int chooseSupplierCurrentPage = (value / chooseSupplierPageSize.value).ceil();
      debugPrint('Current Page: ${chooseSupplierPage.value}');
      debugPrint('Next Page: ${chooseSupplierCurrentPage + 1}');
      chooseSupplierPage.value = chooseSupplierCurrentPage + 1;
      chooseSupplierLoadNext.value = true;
    }
    Timer(
      const Duration(seconds: 0), 
      () => scrollController3.animateTo(
        0.0, curve: Curves.easeOut, 
        duration: const Duration(milliseconds: 300)
      ),
    );  
    getAllSuppliers(page: chooseSupplierPage.value);
  }

  // [READ] Get All Purchases
  void getPurchasesReport({
    String? searchKeyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    PurchaseResponse? purchaseResponse;

    try {
      final purchaseData = await dio.get(
        "${BaseUrlLocal.purchase}?&pageSize=${pageSize.value}&page=$page",
      );
      debugPrint('Products: ${purchaseData.data}');
      purchaseResponse = PurchaseResponse.fromJson(purchaseData.data);
      if(loadNext.value == true){
        dataList.addAll(purchaseResponse.data!.purchase ?? []); 
        loadNext.value = false;
      } else{
        dataList = purchaseResponse.data!.purchase ?? [];
      }
      totalItems.value = purchaseResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [READ] Get Purchase Detail
  Future<void> getPurchasesDetail({
    // String? searchKeyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    PurchaseDetailResponse? purchaseResponse;

    try {
      final purchaseDetailData = await dio.get(
        "${BaseUrlLocal.purchaseDetail(purchaseID: purchaseDetail?.purchaseId)}?&pageSize=${detailPageSize.value}&page=$detailPage",
      );
      debugPrint('Purchase Detail: ${purchaseDetailData.data}');
      purchaseResponse = PurchaseDetailResponse.fromJson(purchaseDetailData.data);
      if(detailLoadNext.value == true){
        detailDataList.addAll(purchaseResponse.data!.purchaseDetail ?? []); 
        detailLoadNext.value = false;
      } else{
        detailDataList = purchaseResponse.data!.purchaseDetail ?? [];
      }
      detailTotalItems.value = purchaseResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [DELETE] Delete Purchase Report
  void deletePurchaseReport({
    required int purchaseId, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final purchaseData = await dio.delete(
        BaseUrlLocal.deletePurchase(purchaseID: purchaseId)
      );
      debugPrint('Delete Purchase: ${purchaseData.data}');
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

  // [READ] Get All Suppliers
  Future<void> getAllSuppliers({
    String? keyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    SupplierResponse? supplierResponse;

    try {
      final supplierData = await dio.get(
        "${BaseUrlLocal.supplier}?keyword=${keyword ?? ""}&pageSize=${chooseSupplierPageSize.value}&page=$chooseSupplierPage",
      );
      debugPrint('Suppliers: ${supplierData.data}');
      supplierResponse = SupplierResponse.fromJson(supplierData.data);
      if(chooseSupplierLoadNext.value == true){
        supplierDataList.addAll(supplierResponse.data!.supplier ?? []); 
        chooseSupplierLoadNext.value = false;
      } else{
        supplierDataList = supplierResponse.data!.supplier ?? [];
      }
      chooseSupplierTotalItems.value = supplierResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
    update(["supplier-table"]);
  }
}