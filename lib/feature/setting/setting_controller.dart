import 'dart:io';

import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';
import 'package:backoffice_tpt_app/feature/main/main_controller.dart';
import 'package:backoffice_tpt_app/model/role.dart';
import 'package:backoffice_tpt_app/model/role_detail.dart';
import 'package:backoffice_tpt_app/model/user_detail.dart';
import 'package:backoffice_tpt_app/utills/helper/loading_helper.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/model/user.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/snackbar/snackbar_widget.dart';
import 'package:image_picker/image_picker.dart';
import '/feature/auth/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;

class SettingController extends GetxController {
  final AuthController authController = AuthController.find;
  final MainController mainController = MainController.find;
  final GlobalKey<FormBuilderState> editUserFormKey = GlobalKey<FormBuilderState>();
  
  UserData? get user => authController.user;
  late UserData dataObject;

  FirebaseAuth auth = FirebaseAuth.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  XFile? image;

  var settingTabIndex = 0;
  Role? editRoleResult;

  void changeTabIndex(int index) {
    settingTabIndex = index;
    update();
  }

  @override
  void onInit() async {
    getRoles();
    await getUserDetail(
      userId: user?.userId
    );
    update();
    super.onInit();
  }

  Future<void> refreshPage() async {
    getRoles();
    await getUserDetail(
      userId: user?.userId
    );
    update();
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      await authController.signOut();
    } catch (e) {
      Get.snackbar(
        "TERJADI KESALAHAN", 
        "Tidak dapat logout."
      );
    }
  }

  Future<void> sendPasswordResetEmail(
    BuildContext context
  ) async {
    try {
      await auth.sendPasswordResetEmail(
        email: user?.email ?? "-"
      );
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Password reset email sent to ${user?.email ?? "-"}", 
        buttonText: "OK"
      );
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Oops!",
        subtitle: "Error sending password reset email: ${user?.email ?? "-"}"
      );
    }
  }

  void editProfile({
    required String name,
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
          "user_id": user?.userId,
          "name": name,
          "address": address,
          "phone_number": phoneNumber,
        },
      );
      debugPrint('Edit User: ${userData.data}');
      dismissLoading();
      UserData? newUserData = await getUserData(userId: user?.userId);
      await authController.changeUserData(user: newUserData!);
      await refreshPage();
      await mainController.refreshPage();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Edit profile berhasil.", 
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

  // [READ] Get Roles
  Future<List<Role>> getRoles() async {
    final dio = await AppDio().getDIO();
    RoleResponse? roleResponse;
    
    try {
      final roleData = await dio.get(
        BaseUrlLocal.role
      );
      if (roleData.data != null) {
        roleResponse = RoleResponse.fromJson(roleData.data);
        return roleResponse.data!.role!;
      }
      update();
      return [];
    } on DioError catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  // [READ] Get User Detail
  Future<void> getUserDetail({
    int? userId,
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
      editUserFormKey.currentState?.patchValue({
        "name": dataObject.name ?? "",
        "email": dataObject.email ?? "",
        "address": dataObject.address ?? "",
        "phone_number": dataObject.phoneNumber ?? "",
      });
      editRoleResult = await getRoleDetail(roleId: dataObject.roleId);
      update(['edit-profile']);
      update();
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
  }

  // [READ] Get User
  Future<UserData?> getUserData({
    int? userId,
  }) async {
    final dio = await AppDio().getDIO();
    UserDetailResponse? userDetailResponse;

    try {
      final userData = await dio.get(
        BaseUrlLocal.userByID(userId: userId)
      );
      debugPrint('User Detail : ${userData.data}');
      userDetailResponse = UserDetailResponse.fromJson(userData.data);
      return userDetailResponse.data!.user!;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
    return null;
  }

  // [READ] Get Role Detail
  Future<Role?> getRoleDetail({int? roleId}) async {
    final dio = await AppDio().getDIO();
    RoleDetailResponse? roleDetailResponse;
    
    try {
      final roleDetailData = await dio.get(
        BaseUrlLocal.roleByID(roleId: roleId)
      );
      debugPrint('Role Detail : ${roleDetailData.data}');
      roleDetailResponse = RoleDetailResponse.fromJson(roleDetailData.data);
      return roleDetailResponse.data?.role;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    update();
    return null;
  }

  void pickImage({
    required BuildContext context,
  }) async {
    final ImagePicker picker = ImagePicker();
    String uid = auth.currentUser!.uid;
    // Pick an image
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final metadata = s.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': image!.path}
      );
      String ext = image!.name.split(".").last;
      s.Reference ref = storage.ref(uid).child("profile.$ext");
      if (kIsWeb) {
        await ref.putData(await image!.readAsBytes(), metadata);
      } else {
        await ref.putFile(File(image!.path), metadata);
      }

      String profileUrl = await ref.getDownloadURL();      
      debugPrint('filename: $profileUrl');

      // ignore: use_build_context_synchronously
      await editProfilePicture(
        image: profileUrl,
        context: context
      );
    }
  }

  Future<void> editProfilePicture({
    required String image,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final userData = await dio.put(
        BaseUrlLocal.user,
        data: {
          "user_id": user?.userId,
          "profile_picture": image,
        },
      );
      debugPrint('Edit User: ${userData.data}');
      dismissLoading();
      UserData? newUserData = await getUserData(userId: user?.userId);
      await authController.changeUserData(user: newUserData!);
      await refreshPage();
      await mainController.refreshPage();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Edit profile berhasil.", 
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
}
