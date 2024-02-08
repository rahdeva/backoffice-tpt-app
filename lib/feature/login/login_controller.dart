// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';
import '/resources/resources.dart';
import '/utills/widget/snackbar/snackbar_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import '/data/local/storage/storage_constants.dart';
import '/data/remote/base/base_controller.dart';
import '/feature/auth/auth_controller.dart';
import '/model/user.dart';

class LoginController extends BaseController<User> {
  final AuthController authController = AuthController.find;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> forgotFormKey = GlobalKey<FormBuilderState>();

  bool isObscure = true;

  @override
  void loadNextPage() {}

  @override
  void refreshPage() {}

  @override
  get statusData => dataObj;

  @override
  String get storageName => StorageName.USERS;

  @override
  Future<void> onReady() async {
    super.onReady();
    await Permission.storage.request();
  }
  
  void loginWithEmailAndPassword(
    String emailInput,
    String passwordInput,
  ) async {
    final dio = await AppDio().getBasicDIO();
    UserResponse? userResponse;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInput,
        password: passwordInput,
      );

      if (userCredential.user!.emailVerified == true) {
        // insert data detail user API
        final userIdToken = await FirebaseAuth.instance.currentUser?.getIdToken();

        // Cek User Data by UID
        try{
          final loginData = await dio.get(
            BaseUrlLocal.userByUID(uid: userCredential.user!.uid),
          );
          debugPrint('User Info: ${loginData.data}');
          userResponse = UserResponse.fromJson(loginData.data);
          await authController.saveAuthData(
            user: userResponse.data!.user!,
            token: userIdToken ?? ""
          );
          authController.setAuth();
        }
        catch (e){
          FirebaseAuth.instance.signOut();
          SnackbarWidget.defaultSnackbar(
            icon: const Icon(
              Icons.cancel,
              color: AppColors.red,
            ),
            title: "Oops!",
            subtitle: "User belum terdaftar dalam database"
          );
        }
      } else {
        Get.defaultDialog(
          radius : 8,
          titlePadding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          contentPadding: const EdgeInsets.all(24),
          titleStyle: const TextStyle(
            fontSize: 28,
            color: AppColors.black,
            fontWeight: FontWeight.w600
          ),
          middleTextStyle: const TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w500
          ),
          backgroundColor: AppColors.white,
          title: "Belum Terverikasi",
          middleText:
            "Apakah kamu ingin mengirim email verifikasi kembali ? \nMohon cek juga pada bagian spam",
          actions: [
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await userCredential.user!.sendEmailVerification();
                  Get.back();
                  debugPrint("BERHASIL MENGIRIM EMAIL VERIFIKASI");
                  SnackbarWidget.defaultSnackbar(
                    icon: const Icon(
                      Icons.check_circle,
                      color: AppColors.green,
                    ),
                    title: "BERHASIL",
                    subtitle: "Kami telah mengirimkan email verifikasi. Buka email kamu untuk tahap verifikasi."
                  );
                } catch (e) {
                  Get.back();
                  SnackbarWidget.defaultSnackbar(
                    icon: const Icon(
                      Icons.cancel,
                      color: AppColors.red,
                    ),
                    title: "Oops!",
                    subtitle: "Kamu terlalu banyak meminta kirim email verifikasi."
                  );
                }
              },
              child: const Text(
                "Kirim Ulang",
                style: TextStyle(
                  color: AppColors.white
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Oops!", 
          subtitle: "Tidak ditemukan User dengan Email yang Anda masukkan."
        );
      } else if (e.code == 'wrong-password') {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Oops!", 
          subtitle: "Password yang Anda masukkan salah."
        );
      } else if (e.code == 'invalid-email') {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Oops!", 
          subtitle: "Email yang Anda masukkan salah."
        );
      } else if (e.code == 'invalid-credential') {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Oops!", 
          subtitle: "Email atau password yang Anda masukkan salah."
        );
      } else {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Oops!", 
          subtitle: e.message.toString()
        );
      }
    }
  }
}
