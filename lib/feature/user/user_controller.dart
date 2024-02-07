import 'dart:async';

import 'package:backoffice_tpt_app/model/all_user.dart';
import 'package:backoffice_tpt_app/model/user.dart';
import 'package:backoffice_tpt_app/model/user_detail.dart';
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

class UserController extends GetxController {
  final GlobalKey<FormBuilderState> searchformKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> addUserFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> editUserFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> deleteUserFormKey = GlobalKey<FormBuilderState>();
  final tableKey = GlobalKey<PaginatedDataTableState>();
  final scrollController = ScrollController();
  bool isLoading = false;

  List<UserData> dataList = [];
  late UserData dataObject;

  Rx<int> page = Rx(1);
  Rx<int> totalItems = Rx(0);
  Rx<int> pageSize = Rx(10);
  Rx<bool> loadNext = Rx(false);
  Rx<String> searchKeyword = Rx("");

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }

  Future<void> refreshPage() async {
    dataList.clear();
    page.value = 1;
    pageSize.value = 10;
    searchformKey.currentState?.reset();
    searchKeyword.value = "";
    tableKey.currentState?.pageTo(1);
    await getAllUsers();
    update();
  }

  void onRowsPerPageChanged(value){
    pageSize.value = value;
    page.value = 1;
    dataList.clear();
    tableKey.currentState?.pageTo(1);
    getAllUsers();
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
    getAllUsers(page: page.value);
  }

  // [READ] Get All Users
  Future<void> getAllUsers({
    String? keyword,
    int page = 1,
  }) async {
    isLoading = true;
    final dio = await AppDio().getDIO();
    AllUserResponse? userResponse;

    try {
      final usersData = await dio.get(
        "${BaseUrlLocal.user}?keyword=${keyword ?? ""}&pageSize=${pageSize.value}&page=$page",
      );
      debugPrint('Users: ${usersData.data}');
      userResponse = AllUserResponse.fromJson(usersData.data);
      if(loadNext.value == true){
        dataList.addAll(userResponse.data!.user ?? []); 
        loadNext.value = false;
      } else{
        dataList = userResponse.data!.user ?? [];
      }
      totalItems.value = userResponse.data!.meta!.totalItems!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }

  // [CREATE] Add New User
  void addNewUser({
    required String roleId,
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getBasicDIO();

    try {
      final userData = await dio.post(
        BaseUrlLocal.user,
        data: {
          "role_id": int.parse(roleId),
          "uid": "user123",
          "name": name,
          "email": email,
          "address": address,
          "phone_number": phoneNumber,
          "profile_picture": ""
        },
      );
      debugPrint('Tambah User: ${userData.data}');
      dismissLoading();
      Get.back();
      getAllUsers();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "User berhasil ditambahkan.", 
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

  // [READ] Get User Detail
  Future<void> getUserDetail({
    int? userId,
    bool? isEdit
  }) async {
    final dio = await AppDio().getDIO();
    UserDetailResponse? userDetailResponse;

    try {
      final userData = await dio.get(
        BaseUrlLocal.userByID(userId: userId)
      );
      debugPrint('User Detail : ${userData.data}');
      userDetailResponse = UserDetailResponse.fromJson(userData.data);
      dataObject = userDetailResponse.data!.user!;
      isEdit == true
      ? editUserFormKey.currentState!.patchValue({
          "role_id": dataObject.roleId.toString(),
          "name": dataObject.name,
          "email": dataObject.email,
          "address": dataObject.address,
          "phone_number": dataObject.phoneNumber,
        })
      : deleteUserFormKey.currentState!.patchValue({
          "role_id": dataObject.roleId.toString(),
          "name": dataObject.name,
          "email": dataObject.email,
          "address": dataObject.address,
          "phone_number": dataObject.phoneNumber,
        });
      update();
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
  }

  // [UPDATE] Update User
  void updateUser({
    required int userId, 
    required String roleId,
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final userData = await dio.put(
        BaseUrlLocal.user,
        data: {
          "user_id": userId,
          "role_id": int.parse(roleId),
          "name": name,
          "email": email,
          "address": address,
          "phone_number": phoneNumber,
        },
      );
      debugPrint('Edit User: ${userData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "User berhasil diperbaharui.", 
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
  
  // [DELETE] Delete User
  void deleteUser({
    required int userId, 
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final userData = await dio.delete(
        BaseUrlLocal.deleteUser(userId: userId)
      );
      debugPrint('Delete User: ${userData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "User berhasil dihapus.", 
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