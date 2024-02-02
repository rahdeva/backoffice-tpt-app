import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';
import 'package:backoffice_tpt_app/model/barang.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationController extends GetxController {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  bool isLoading = false;

  Rx<int> page = Rx(1);

  List<Barang> dataList = [];
  
  @override
  void onInit() {
    getAllNotification();
    super.onInit();
  }

  void refreshPage() async {
    dataList = [];
    getAllNotification();
    update();
    refreshController.refreshCompleted();
  }

  void getAllNotification() async {
    print("getData");
    isLoading = true;
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: 30000,
        receiveTimeout: 30000,
        headers: {
          "Content-Type": 'application/json',
        }
      ),
    );
    BarangResponse? notificationResponse;

    try {
      final notifiationRequest = await dio.get(
        BaseUrlLocal.product
      );
      debugPrint('Notification: ${notifiationRequest.data}');
      notificationResponse = BarangResponse.fromJson(notifiationRequest.data);
      dataList = notificationResponse.data ?? [];
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }
}
