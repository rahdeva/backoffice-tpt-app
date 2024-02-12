import 'dart:async';

import 'package:backoffice_tpt_app/model/sale_detail.dart';
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
import 'package:backoffice_tpt_app/model/sale.dart';

class SaleReportController extends GetxController {
  final GlobalKey<FormBuilderState> searchformKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> addSaleReportFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> editSaleReportFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> deleteSaleReportFormKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final tableDetailKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  final scrollController2 = ScrollController();
  bool isLoading = false;

  List<Sale> dataList = [];
  Sale? saleDetail;
  List<SaleDetail> detailDataList = [];

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);

  Rx<int> detailPage = Rx(1);
  Rx<int> detailTotalItems = Rx(0);
  Rx<int> detailPageSize = Rx(8);
  Rx<bool> detailLoadNext = Rx(false);

  @override
  void onInit() {
    getSalesReport();
    super.onInit();
  }

  Future<void> refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    await getSalesReport();
    update();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    getSalesReport();
  }

  void onDetailRowsPerPageChanged(value){
    detailPageSize.value = value;
    detailPage.value = 1;
    detailDataList.clear();
    tableDetailKey.currentState?.pageTo(1);
    getSalesDetail();
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
    getSalesReport(page: page.value);
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
    getSalesDetail(page: detailPage.value);
  }

  // [READ] Get All Sales
  Future<void> getSalesReport({
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    SaleResponse? saleResponse;

    try {
      final saleData = await dio.get(
        "${BaseUrlLocal.sale}?&pageSize=${pageSize.value}&page=$page",
      );
      debugPrint('Sale: ${saleData.data}');
      saleResponse = SaleResponse.fromJson(saleData.data);
      if(loadNext.value == true){
        dataList.addAll(saleResponse.data!.sale ?? []); 
        loadNext.value = false;
      } else{
        dataList = saleResponse.data!.sale ?? [];
      }
      totalItems.value = saleResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [READ] Get Sales Detail
  Future<void> getSalesDetail({
    // String? searchKeyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    SaleDetailResponse? saleDetailResponse;

    try {
      final saleDetailData = await dio.get(
        "${BaseUrlLocal.saleDetail(saleID: saleDetail?.saleId)}?&pageSize=${detailPageSize.value}&page=$detailPage",
      );
      debugPrint('Sale Detail: ${saleDetailData.data}');
      saleDetailResponse = SaleDetailResponse.fromJson(saleDetailData.data);
      if(detailLoadNext.value == true){
        detailDataList.addAll(saleDetailResponse.data!.saleDetail ?? []); 
        detailLoadNext.value = false;
      } else{
        detailDataList = saleDetailResponse.data!.saleDetail ?? [];
      }
      detailTotalItems.value = saleDetailResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [DELETE] Delete Sale Report
  void deleteSaleReport({
    required int saleId, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final saleData = await dio.delete(
        BaseUrlLocal.deleteSale(saleID: saleId)
      );
      debugPrint('Delete Sale: ${saleData.data}');
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