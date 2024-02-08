import 'dart:async';

import 'package:backoffice_tpt_app/model/supplier.dart';
import 'package:backoffice_tpt_app/model/supplier_detail.dart';
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

class SupplierController extends GetxController {
  final GlobalKey<FormBuilderState> searchformKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> addSupplierFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> editSupplierFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> deleteSupplierFormKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  bool isLoading = false;

  List<Supplier> dataList = [];
  late Supplier dataObject;

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);
  Rx<String> searchKeyword = Rx("");

  RxString addAddressResult = "".obs;
  RxString editAddressResult = "".obs;
  RxString deleteAddressResult = "".obs;

  @override
  void onInit() {
    getAllSuppliers();
    super.onInit();
  }

  Future<void> refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    searchformKey.currentState?.reset();
    searchKeyword.value = "";
    tableKey.currentState?.pageTo(1);
    await getAllSuppliers();
    update();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
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
    getAllSuppliers(page: page.value);
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
        "${BaseUrlLocal.supplier}?keyword=${keyword ?? ""}&pageSize=${pageSize.value}&page=$page",
      );
      debugPrint('Suppliers: ${supplierData.data}');
      supplierResponse = SupplierResponse.fromJson(supplierData.data);
      if(loadNext.value == true){
        dataList.addAll(supplierResponse.data!.supplier ?? []); 
        loadNext.value = false;
      } else{
        dataList = supplierResponse.data!.supplier ?? [];
      }
      totalItems.value = supplierResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [CREATE] Add New Supplier
  void addNewSupplier({
    required String supplierName,
    required String phoneNumber,
    required String address,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getBasicDIO();

    try {
      final supplierData = await dio.post(
        BaseUrlLocal.supplier,
        data: {
          "supplier_name": supplierName,
          "phone_number": phoneNumber,
          "address": address
        },
      );
      debugPrint('Tambah Supplier: ${supplierData.data}');
      dismissLoading();
      Get.back();
      getAllSuppliers();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Supplier berhasil ditambahkan.", 
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

  // [READ] Get Supplier Detail
  Future<void> getSupplierDetail({
    int? supplierId,
    bool? isEdit
  }) async {
    final dio = await AppDio().getDIO();
    SupplierDetailResponse? supplierDetailResponse;

    try {
      final supplierData = await dio.get(
        BaseUrlLocal.supplierByID(supplierId: supplierId)
      );
      debugPrint('Supplier Detail : ${supplierData.data}');
      supplierDetailResponse = SupplierDetailResponse.fromJson(supplierData.data);
      dataObject = supplierDetailResponse.data!.supplier!;
      isEdit == true
      ? editSupplierFormKey.currentState!.patchValue({
          "supplier_name": dataObject.supplierName,
          "phone_number": dataObject.phoneNumber,
          "address": dataObject.address,
        })
      : deleteSupplierFormKey.currentState!.patchValue({
          "supplier_name": dataObject.supplierName,
          "phone_number": dataObject.phoneNumber,
          "address": dataObject.address,
        });
      update();
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
  }

  // [UPDATE] Update Supplier
  void updateSupplier({
    required int supplierId, 
    required String supplierName,
    required String phoneNumber,
    required String address,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final supplierData = await dio.put(
        BaseUrlLocal.supplier,
        data: {
          "supplier_id": supplierId,
          "supplier_name": supplierName,
          "phone_number": phoneNumber,
          "address": address,
        },
      );
      debugPrint('Edit Supplier: ${supplierData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Supplier berhasil diperbaharui.", 
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
  
  // [DELETE] Delete Supplier
  void deleteSupplier({
    required int supplierId, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final supplierData = await dio.delete(
        BaseUrlLocal.deleteSupplier(supplierId: supplierId)
      );
      debugPrint('Delete Supplier: ${supplierData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Supplier berhasil dihapus.", 
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