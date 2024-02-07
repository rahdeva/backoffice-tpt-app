import 'dart:async';

import 'package:backoffice_tpt_app/model/category.dart';
import 'package:backoffice_tpt_app/model/category_detail.dart';
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

class CategoryController extends GetxController {
  final GlobalKey<FormBuilderState> searchformKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> addCategoryFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> editCategoryFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> deleteCategoryFormKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  bool isLoading = false;

  List<Category> dataList = [];
  late Category dataObject;

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(5);
  Rx<bool> loadNext = Rx(false);
  Rx<String> searchKeyword = Rx("");

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  Future<void> refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 5;
    searchformKey.currentState?.reset();
    searchKeyword.value = "";
    tableKey.currentState?.pageTo(1);
    await getAllCategories();
    update();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    getAllCategories();
  }

  void onPageChanged(value) async {
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
    await getAllCategories(
      keyword: searchKeyword.value,
      page: page.value
    );
  }

  // [READ] Get All Products
  Future<void> getAllCategories({
    String? keyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    CategoryResponse? categoryResponse;

    try {
      final categoryData = await dio.get(
        "${BaseUrlLocal.category}?keyword=${keyword ?? ""}&pageSize=${pageSize.value}&page=$page",
      );
      debugPrint('Categories: ${categoryData.data}');
      categoryResponse = CategoryResponse.fromJson(categoryData.data);
      if(loadNext.value == true){
        dataList.addAll(categoryResponse.data!.category ?? []); 
        loadNext.value = false;
      } else{
        dataList = categoryResponse.data!.category ?? [];
      }
      totalItems.value = categoryResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [CREATE] Add New Category
  void addNewCategory({
    required String categoryCode, 
    required String categoryName,
    required String categoryColor,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getBasicDIO();

    try {
      final categoryData = await dio.post(
        BaseUrlLocal.category,
        data: {
          "category_code": categoryCode,
          "category_name": categoryName,
          "category_color": categoryColor,
        },
      );
      debugPrint('Tambah Kategori: ${categoryData.data}');
      dismissLoading();
      Get.back();
      getAllCategories();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Category berhasil ditambahkan.", 
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

  // [READ] Get Category Detail
  Future<void> getCategoryDetail({
    int? categoryId,
    bool? isEdit
  }) async {
    final dio = await AppDio().getDIO();
    CategoryDetailResponse? categoryDetailResponse;

    try {
      final categoryData = await dio.get(
        BaseUrlLocal.categoryByID(categoryId: categoryId)
      );
      debugPrint('Category Detail : ${categoryData.data}');
      categoryDetailResponse = CategoryDetailResponse.fromJson(categoryData.data);
      dataObject = categoryDetailResponse.data!.category!;
      isEdit == true
      ? editCategoryFormKey.currentState!.patchValue({
          "category_code": dataObject.categoryCode,
          "category_name": dataObject.categoryName,
          "category_color": dataObject.categoryColor,
        })
      : deleteCategoryFormKey.currentState!.patchValue({
          "category_code": dataObject.categoryCode,
          "category_name": dataObject.categoryName,
          "category_color": dataObject.categoryColor,
        });
      update();
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
  }

  // [UPDATE] Update Category
  void updateCategory({
    required int categoryId, 
    required String categoryCode, 
    required String categoryName,
    required String categoryColor,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final categoryData = await dio.put(
        BaseUrlLocal.category,
        data: {
          "category_id": categoryId,
          "category_code": categoryCode,
          "category_name": categoryName,
          "category_color": categoryColor,
        },
      );
      debugPrint('Edit Category: ${categoryData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Kategori berhasil diperbaharui.", 
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
  
  // [DELETE] Delete Category
  void deleteCategory({
    required int categoryId, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final categoryData = await dio.delete(
        BaseUrlLocal.deleteCategory(categoryId: categoryId)
      );
      debugPrint('Delete Category: ${categoryData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Category berhasil dihapus.", 
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