// ignore_for_file: unused_local_variable

// import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
// import '/data/remote/endpoint.dart';
// import '/model/login_response.dart';
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

  /*
  void signInWithEmailAndPassword(
    String emailInput,
    String passwordInput,
  ) async {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 30000,
        headers: {
          "Content-Type": 'application/json',
          // "sugoiiyabai": "k/WUgI/f6vxwpeu9SKdm5ddijsqA7nmkraedjUoLvN7BBVN8PIVul1sVV2Jhpj+5"
        }
      ),
    );

    LoginResponse? loginResponse;

    try {
      final loginData = await dio.post(
        BaseUrl.login,
        data: {
          "username": emailInput,
          "password": passwordInput,
        }
      );
      debugPrint('User Info: ${loginData.data}');
      loginResponse = LoginResponse.fromJson(loginData.data);
      await authController.saveAuthData(
        user: loginResponse.data!,
        token: loginResponse.data!.accessToken ?? '',
      );
      authController.setAuth();
    } on DioError catch (error) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        subtitle: "Username atau Password salah",
        title: "Login Gagal!"
      );
      debugPrint(error.toString());
    }
  }
  */
  
  void loginWithEmailAndPassword(
    String emailInput,
    String passwordInput,
  ) async {
    // final Dio dio = Dio(
    //   BaseOptions(
    //     connectTimeout: 30000,
    //     receiveTimeout: 30000,
    //     headers: {
    //       "Content-Type": 'application/json',
    //       // "sugoiiyabai": "k/WUgI/f6vxwpeu9SKdm5ddijsqA7nmkraedjUoLvN7BBVN8PIVul1sVV2Jhpj+5"
    //     }
    //   ),
    // );

    // LoginResponse? loginResponse;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInput,
        password: passwordInput,
      );

      if (userCredential.user!.emailVerified == true) {
        // insert data detail user API
        final userIdToken = await FirebaseAuth.instance.currentUser?.getIdToken();

        await authController.saveAuthData(
          user: UserData(
            email: userCredential.user!.email,
            uid: userCredential.user!.uid,
          ),
          token: userIdToken ?? ""
        );
        authController.setAuth();
      } else {
        Get.defaultDialog(
          title: "Belum Tervefirikasi",
          middleText:
            "Apakah kamu ingin mengirim email verifikasi kembali ? Mohon cek juga pada bagian spam",
          actions: [
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
                  Get.snackbar(
                    "BERHASIL",
                    "Kami telah mengirimkan email verifikasi. Buka email kamu untuk tahap verifikasi."
                  );
                } catch (e) {
                  Get.back();
                  Get.snackbar(
                    "Oops!",
                    "Kamu terlalu banyak meminta kirim email verifikasi."
                  );
                }
              },
              child: const Text("KIRIM LAGI"),
            ),
          ],
        );
      }
      
      // final loginData = await dio.post(
      //   BaseUrl.login,
      //   data: {
      //     "username": emailInput,
      //     "password": passwordInput,
      //   }
      // );
      // debugPrint('User Info: ${loginData.data}');
      // loginResponse = LoginResponse.fromJson(loginData.data);
      // await authController.saveAuthData(
      //   user: loginResponse.data!,
      //   token: loginResponse.data!.accessToken ?? '',
      // );
      // authController.setAuth();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Oops!", 
          "Tidak ditemukan User dengan Email yang Anda masukkan."
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Oops!", 
          "Password yang Anda masukkan salah."
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          "Oops!", 
          "Email yang Anda masukkan salah."
        );
      } else {
        Get.snackbar(
          "Oops!", 
          e.code
        );
      }
    }
  }

  void registerWithEmailAndPassword(
    String emailInput,
    String passwordInput,
  ) async {
    // final Dio dio = Dio(
    //   BaseOptions(
    //     connectTimeout: 30000,
    //     receiveTimeout: 30000,
    //     headers: {
    //       "Content-Type": 'application/json',
    //       // "sugoiiyabai": "k/WUgI/f6vxwpeu9SKdm5ddijsqA7nmkraedjUoLvN7BBVN8PIVul1sVV2Jhpj+5"
    //     }
    //   ),
    // );

    // LoginResponse? loginResponse;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailInput,
        password: passwordInput,
      );

      await userCredential.user!.sendEmailVerification();

      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.check_circle,
          color: AppColors.green,
        ),
        title: "Berhasil Registrasi!", 
        subtitle: "Mohon cek email Anda untuk melakukan verifikasi.",
      );
      
      // if (userCredential != null) {
        // register user to API
        // if (registeredUser == true) {
          // Get.toNamed(PageName.LOGIN);
          // SnackbarWidget.defaultSnackbar(
          //   icon: const Icon(
          //     Icons.check_circle,
          //     color: AppColors.green,
          //   ),
          //   title: "Berhasil Registrasi!", 
          //   subtitle: "Mohon cek email Anda untuk melakukan verifikasi.",
          // );
        // } else {
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Password terlalu lemah!",
          subtitle: "Mohon gunakan password yang lebih kuat.",
        );
      } else if (e.code == 'email-already-in-use') {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Email sudah digunakan!", 
          subtitle: "Mohon gunakan email yang lain.",
        );
      } else {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Terjadi Kesalahan!",
          subtitle: e.toString()
        );
      }
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Terjadi Kesalahan!",
        subtitle: e.toString(),
      );
    }

    // try {
      // final loginData = await dio.post(
      //   BaseUrl.login,
      //   data: {
      //     "username": emailInput,
      //     "password": passwordInput,
      //   }
      // );
      // debugPrint('User Info: ${loginData.data}');
      // loginResponse = LoginResponse.fromJson(loginData.data);
      // await authController.saveAuthData(
      //   user: loginResponse.data!,
      //   token: loginResponse.data!.accessToken ?? '',
      // );
      // authController.setAuth();
    // } on DioError catch (error) {
    //   SnackbarWidget.defaultSnackbar(
    //     icon: const Icon(
    //       Icons.cancel,
    //       color: AppColors.red,
    //     ),
    //     subtitle: "Username atau Password salah",
    //     title: "Login Gagal!"
    //   );
    //   debugPrint(error.toString());
    // }
  }
}
