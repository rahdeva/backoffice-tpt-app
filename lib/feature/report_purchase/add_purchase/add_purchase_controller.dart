import 'dart:async';

import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';
import 'package:backoffice_tpt_app/model/product.dart';
import 'package:backoffice_tpt_app/model/purchase.dart';
import 'package:backoffice_tpt_app/model/supplier.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddPurchaseReportController extends GetxController {
  final GlobalKey<FormBuilderState> addPurchaseFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> searchProductformKey = GlobalKey<FormBuilderState>();
  final tableProductKey = GlobalKey<PaginatedDataTableState>();
  final scrollController2 = ScrollController();
  bool isLoading = false;

  Purchase? purchaseDetail;
  Supplier? supplierChoosen;

  List<Product> productDataList = [];

  Rx<int> productPage = Rx(1);
  Rx<int> productTotalItems = Rx(0);
  Rx<int> productPageSize = Rx(8);
  Rx<bool> productLoadNext = Rx(false);
  Rx<String> searchProductKeyword = Rx("");

  Rx<int> total = Rx(0);

  @override
  void onInit() {
    supplierChoosen = Get.arguments;
    super.onInit();
  }

  void onProductRowsPerPageChanged(value){
    productPageSize.value = value;
    productPage.value = 1;
    productDataList.clear();
    tableProductKey.currentState?.pageTo(1);
    getAllProducts();
  }

  void onProductPageChanged(value){
    if(value == 1){
      productPage.value = 1;
    } else{
      int productCurrentPage = (value / productPageSize.value).ceil();
      debugPrint('Current Page: ${productPage.value}');
      debugPrint('Next Page: ${productCurrentPage + 1}');
      productPage.value = productCurrentPage + 1;
      productLoadNext.value = true;
    }
    Timer(
      const Duration(seconds: 0), 
      () => scrollController2.animateTo(
        0.0, curve: Curves.easeOut, 
        duration: const Duration(milliseconds: 300)
      ),
    );  
    getAllProducts(page: productPage.value);
  }

  // [READ] Get All Products
  Future<void> getAllProducts({
    String? keyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    ProductResponse? productResponse;

    try {
      final productData = await dio.get(
        "${BaseUrlLocal.product}?keyword=${keyword ?? ""}&pageSize=${productPageSize.value}&page=$productPage",
      );
      debugPrint('Suppliers: ${productData.data}');
      productResponse = ProductResponse.fromJson(productData.data);
      if(productLoadNext.value == true){
        productDataList.addAll(productResponse.data!.product ?? []); 
        productLoadNext.value = false;
      } else{
        productDataList = productResponse.data!.product ?? [];
      }
      productTotalItems.value = productResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
    update(["product-table"]);
  }
}