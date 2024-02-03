import 'dart:async';

import 'package:backoffice_tpt_app/model/purchase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';

class PurchaseReportController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  bool isLoading = false;

  List<Purchase> dataList = [];

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);

  @override
  void onInit() {
    getPurchasesReport();
    super.onInit();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    getPurchasesReport();
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
  
  void refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    formKey.currentState!.reset();
    getPurchasesReport();
    update();
  }

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
}