import 'dart:async';
import 'dart:io';

import 'package:backoffice_tpt_app/model/product.dart';
import 'package:backoffice_tpt_app/model/product_detail.dart';
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

class ProductController extends GetxController {
  final GlobalKey<FormBuilderState> searchformKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> addProductFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> editProductFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> deleteProductFormKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  bool isLoading = false;

  List<Product> dataList = [];
  late Product dataObject;

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);
  Rx<String> searchKeyword = Rx("");

  File? newImage;
  String? imageUploadfilename;

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  Future<void> refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    searchformKey.currentState?.reset();
    searchKeyword.value = "";
    tableKey.currentState?.pageTo(1);
    await getAllProducts();
    update();
  }

  void onRowsPerPageChanged(value) async {
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    await getAllProducts();
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
    await getAllProducts(
      keyword: searchKeyword.value,
      page: page.value
    );
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
        "${BaseUrlLocal.product}?keyword=${keyword ?? ""}&pageSize=${pageSize.value}&page=$page",
      );
      debugPrint('Products: ${productData.data}');
      productResponse = ProductResponse.fromJson(productData.data);
      if(loadNext.value == true){
        dataList.addAll(productResponse.data!.product ?? []); 
        loadNext.value = false;
      } else{
        dataList = productResponse.data!.product ?? [];
      }
      totalItems.value = productResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [CREATE] Add New Product
  void addNewProduct({
    required String productCode, 
    required String productName,
    required String categoryID, 
    required String brand,
    required String purchasePrice, 
    required String salePrice, 
    required String stock, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getBasicDIO();

    try {
      final productData = await dio.post(
        BaseUrlLocal.product,
        data: {
          "product_code": productCode,
          "product_name": productName,
          "category_id": int.parse(categoryID),
          "brand": brand,
          "purchase_price": StringFormatter.formatCurrencyNumber(purchasePrice),
          "sale_price": StringFormatter.formatCurrencyNumber(salePrice),
          "stock": int.parse(stock),
          "sold": 0,
          "image": ""
        },
      );
      debugPrint('Tambah Produk: ${productData.data}');
      dismissLoading();
      Get.back();
      getAllProducts();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Product berhasil ditambahkan.", 
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

  // [READ] Get Product Detail
  Future<void> getProductDetail({
    int? productId,
    bool? isEdit
  }) async {
    final dio = await AppDio().getDIO();
    ProductDetailResponse? productDetailResponse;

    try {
      final productData = await dio.get(
        BaseUrlLocal.productByID(productId: productId)
      );
      debugPrint('Product Detail : ${productData.data}');
      productDetailResponse = ProductDetailResponse.fromJson(productData.data);
      dataObject = productDetailResponse.data!.product!;
      isEdit == true
      ? editProductFormKey.currentState!.patchValue({
          'product_code' : dataObject.productCode,
          'product_name' : dataObject.productName,
          'category_id' : dataObject.categoryId.toString(),
          'brand' : dataObject.brand,
          'purchase_price' : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.purchasePrice),
          'sale_price' : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.purchasePrice),
          'stock' : dataObject.stock.toString(),
        })
      : deleteProductFormKey.currentState!.patchValue({
          'product_code' : dataObject.productCode,
          'product_name' : dataObject.productName,
          'category_id' : dataObject.categoryId.toString(),
          'brand' : dataObject.brand,
          'purchase_price' : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.purchasePrice),
          'sale_price' : NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: "Rp "
          ).format(dataObject.purchasePrice),
          'stock' : dataObject.stock.toString(),
        });
      update();
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
  }

  // [UPDATE] Update Product
  void updateProduct({
    required int productId, 
    required String productCode, 
    required String productName,
    required String categoryID, 
    required String brand,
    required String purchasePrice, 
    required String salePrice, 
    required String stock, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final productData = await dio.put(
        BaseUrlLocal.product,
        data: {
          "product_id": productId,
          "product_code": productCode,
          "product_name": productName,
          "category_id": int.parse(categoryID),
          "brand": brand,
          "purchase_price": StringFormatter.formatCurrencyNumber(purchasePrice),
          "sale_price": StringFormatter.formatCurrencyNumber(salePrice),
          "stock": int.parse(stock),
          "image": ""
        },
      );
      debugPrint('Edit Product: ${productData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Produk berhasil diperbaharui.", 
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

  // [DELETE] Delete Product
  void deleteProduct({
    required int productId, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final productData = await dio.delete(
        BaseUrlLocal.deleteProduct(productId: productId)
      );
      debugPrint('Delete Product: ${productData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Product berhasil dihapus.", 
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

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(
  //       source: source,
  //       // imageQuality: 50, // <- Reduce Image quality
  //       // maxHeight: 500,  // <- reduce the image size
  //       // maxWidth: 500
  //     );
  //     if (image == null) return;
  //     File? img = File(image.path);
  //     img = await _cropImage(imageFile: img);
  //     newImage = img;
  //     update();
  //     Get.back();
  //   } on PlatformException catch (e) {
  //     debugPrint(e.toString());
  //     Get.back();
  //   }
  // }

  // Future<File?> _cropImage({required File imageFile}) async {
  //   CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }

  // void showSelectImageOptions(BuildContext context) {
  //   BottomSheetWidget.showSimpleBottomSheet(
  //     context, 
  //     titleText: "Tambah Dokumen Pendukung",
  //     bottomSheetContent: SelectImageOptionsWidget(
  //       onTap: pickImage,
  //     ), 
  //   );
  // }
}