import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import '/data/remote/dio.dart';
// import '/data/remote/endpoint.dart';
// import '/feature/auth/auth_controller.dart';
// import '/model/api_error.dart';
// import '/model/login_response.dart';
// import '/model/user.dart';
// import '/resources/resources.dart';
// import '/utills/helper/static_value_helper.dart';
// import '/utills/widget/snackbar/snackbar_widget.dart';

class APILogInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('');
    debugPrint('# ERROR');
    debugPrint('<-- ${err.response?.statusCode} - ${err.requestOptions.uri}');
    debugPrint('Message: ${err.error}');
    debugPrint('<-- END HTTP');
    // APIError apiError = APIError.fromJson(err.response?.data);
    // if (err.response?.statusCode == 401) {
    //   debugPrint('<-- Refresh Token');
    //   // refreshToken();
    // }
    // if (err.response?.statusCode != 401) {
    //   SnackbarWidget.defaultSnackbar(
    //     icon: const Icon(
    //       Icons.cancel,
    //       color: AppColors.red,
    //     ),
    //     // title: "Error - ${apiError.error?.code}",
    //     title: "Terjadi Kesalahan",
    //     subtitle: StaticValueHelper.apiError[apiError.error?.code] ?? "Mohon ulangi lagi nanti",
    //   );
    // }
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('');
    debugPrint('# REQUEST');
    final method = options.method.toUpperCase();
    debugPrint('--> $method - ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    debugPrint('Data: ${options.data}');
    debugPrint('--> END $method');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('');
    debugPrint('# RESPONSE');
    debugPrint('<-- ${response.statusCode} - ${response.requestOptions.uri}');
    debugPrint('Response: ${response.data}');
    debugPrint('<-- END HTTP');
    debugPrint("response.statusCode.toString()");
    debugPrint(response.statusCode.toString());
    debugPrint("response.statusCode.toString()");
    // debugPrint(response.data.toString());
    // if (response.statusCode == 401) {
    //   debugPrint('<-- Refresh Token');
    //   // refreshToken();
    // }
    return super.onResponse(response, handler);
  }

  // void refreshToken() async {
  //   final dio = await AppDio().getDIO();
  //   LoginResponse? loginResponse;
  //   UserData? currentUser = AuthController.find.user;

  //   try {
  //     final refreshTokenData = await dio.post(
  //       BaseUrl.refreshToken,
  //       data: {
  //         "refresh_token": currentUser!.refreshToken,
  //       }
  //     );
  //     debugPrint('Refresh Token Info: ${refreshTokenData.data}');
  //     loginResponse = LoginResponse.fromJson(refreshTokenData.data);
  //     await AuthController.find.saveAuthData(
  //       user: loginResponse.data!,
  //       token: loginResponse.data!.accessToken ?? '',
  //     );
  //     AuthController.find.setAuth();
  //   } on DioError catch (error) {
  //     debugPrint(error.toString());
  //     await AuthController.find.signOut();
  //   }
  // }
}
