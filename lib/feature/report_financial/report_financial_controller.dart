import 'dart:async';

import 'package:backoffice_tpt_app/model/financial.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';

class FinancialReportController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  bool isLoading = false;

  List<Financial> dataList = [];

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);

  @override
  void onInit() {
    getSalesHistory();
    super.onInit();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    getSalesHistory();
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
    getSalesHistory(page: page.value);
  }
  
  void refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    formKey.currentState!.reset();
    getSalesHistory();
    update();
  }

  void getSalesHistory({
    String? searchKeyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    FinancialResponse? financialResponse;

    try {
      final financialData = await dio.get(
        "${BaseUrlLocal.financial}?&pageSize=${pageSize.value}&page=$page",
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
}