import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/data/local/storage/storage_manager.dart';
import '/data/remote/base/base_refresher_status.dart';

abstract class BaseController<T> extends GetxController {
  StorageManager storage = StorageManager();

  T? dataObj;
  List<T> dataList = [];

  Rx<int> page = Rx(1);
  Rx<bool> hasNext = Rx(false);
  Rx<int> perPage = Rx(10);

  String message = "";

  get statusData;
  bool get isUsingList => statusData is List;
  String get storageName;
  void refreshPage();
  void loadNextPage();

  Rx<RefresherStatus> status = Rx(RefresherStatus.initial);

  bool get isInitial => status.value == RefresherStatus.initial;

  /// **Note:**
  /// loading with probably data is not empty
  bool get isLoading => status.value == RefresherStatus.loading;

  /// **Note:**
  /// loading with no data from the beginning
  bool get isShimmering => isLoading && isEmptyData;

  bool get isEmptyData => isUsingList ? dataList.isEmpty : dataObj == null;
  bool get isSuccess => status.value == RefresherStatus.success;
  bool get isError => status.value == RefresherStatus.failed && isEmptyData;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCacheAndFinish]
  // Future<void> getCache({String id = '0'}) async {
  //   var cache = storage.get(storageName);
  //   if (storage.has(storageName)) {
  //     if (cache != null && cache.toString().isNotEmpty) {
  //       if (isUsingList) {
  //         _setFinishCallbacks(
  //             list: List<T>.from(
  //                 json.decode(cache).map((x) => Converter<T>().fromJson(x))));
  //       } else {
  //         if (id == getId(cache)) {
  //           _setFinishCallbacks(data: Converter<T>().fromJson(cache));
  //         }
  //       }
  //     }
  //   }
  // }

  String getId(Map<String, dynamic> cache) {
    return (cache['id'] ?? '0').toString();
  }

  /// **NOTE:**
  /// call this to finish the load data,
  /// don't need to call [finishLoadData] anymore
  // Future<void> saveCacheAndFinish(
  //     {List<T>? list, T? data, int page = 1}) async {
  //   this.page.value = page;
  //   await storage.write(
  //       storageName,
  //       isUsingList
  //           ? json.encode(list ?? [])
  //           : (data != null ? Converter<T>().toJson(data) : ""));
  //   finishLoadData(list: list, data: data);
  // }

  /// **Note:**
  /// the state will go to error state if the [errorMessage] is not null,
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data is not require to saved in local data
  void finishLoadData({
    String errorMessage = "",
    List<T>? list = const [],
    T? data,
  }) {
    if (errorMessage.isNotEmpty) {
      _setErrorStatus(errorMessage);
    } else {
      _setFinishCallbacks(list: list, data: data);
    }
    update();
  }

  /// **NOTE:**
  /// call this to change state to Loading State
  loadingState() {
    status.value = RefresherStatus.loading;
    update();
  }

  /// **NOTE:**
  /// call this to change state to Success State
  successState() {
    status.value = RefresherStatus.success;
    update();
  }

  /// **NOTE:**
  /// call this to change state to Success State
  emptyState() {
    status.value = RefresherStatus.empty;
    update();
  }

  /// **NOTE:**
  /// call this to change state to Error State
  errorState() {
    status.value = RefresherStatus.empty;
    update();
  }

  void _addData(List<T> data) {
    if (page.value == 1) {
      dataList.clear();
    }
    if (data.isNotEmpty) {
      this.dataList.addAll(data);
    } else {
      if (isUsingList) {
        emptyState();
      }
    }
    hasNext.value = data.isNotEmpty;
  }

  void _setData(T? data) {
    if (data != null) {
      this.dataObj = data;
    } else if (!isUsingList) {
      emptyState();
    }
  }

  void _setFinishCallbacks({List<T>? list, T? data}) {
    _addData(list ?? []);
    _setData(data);
    successState();
    _finishRefresh();
  }

  void _setErrorStatus(String message) {
    errorState();
    message = (message.isNotEmpty) ? message : "Something when wrong..";
    Get.snackbar('txt_error_title'.tr, message.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void _finishRefresh() {
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
    update();
  }

  Future<void> showLoading({String? message}) async {
    if (Get.overlayContext != null && Get.isOverlaysClosed) {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [CircularProgressIndicator()],
              ),
            ),
          ),
        ),
      );
    }
  }

  dismissLoading() {
    if (Get.overlayContext != null) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
