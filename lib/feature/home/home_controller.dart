import 'package:backoffice_tpt_app/model/home.dart';
import 'package:backoffice_tpt_app/model/home_grid.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../main/main_controller.dart';

class HomeController extends GetxController {
  static HomeController find = Get.find();
  final MainController mainC = MainController.find;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  Home? homeData;

  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  void refreshPage() async {
    getHomeData();
  }

  List<HomeGrid> gridHomeData = [
    HomeGrid(
      id: 0,
      title: "Total Produk",
      total: 0,
      isPrice: false,
      icon: FaIcon(
        FontAwesomeIcons.boxesStacked,
        color: AppColors.background1,
        size: 3.5.w,
      ),
    ),
    HomeGrid(
      id: 1,
      title: "Total Kategori",
      total: 0,
      isPrice: false,
      icon: FaIcon(
        FontAwesomeIcons.box,
        color: AppColors.background1,
        size: 3.5.w,
      )
    ),
    HomeGrid(
      id: 2,
      title: "Total Supplier",
      total: 0,
      isPrice: false,
      icon: FaIcon(
        FontAwesomeIcons.truck,
        color: AppColors.background1,
        size: 3.w,
      )
    ),
    HomeGrid(
      id: 3,
      title: "Total User",
      total: 0,
      isPrice: false,
      icon: FaIcon(
        FontAwesomeIcons.users,
        color: AppColors.background1,
        size: 3.5.w,
      )
    ),
    HomeGrid(
      id: 4,
      title: "Total Penjualan Hari Ini",
      total: 0,
      isPrice: true,
      icon: FaIcon(
        FontAwesomeIcons.upload,
        color: AppColors.background1,
        size: 3.5.w,
      )
    ),
    HomeGrid(
      id: 5,
      title: "Total Pembelian Hari Ini",
      total: 0,
      isPrice: true,
      icon: FaIcon(
        FontAwesomeIcons.download,
        color: AppColors.background1,
        size: 3.5.w,
      )
    ),
  ];

  void getHomeData() async {
    isLoading = true;
    final dio = await AppDio().getBasicDIO();
    HomeResponse? homeResponse;

    try {
      final homeResponseData = await dio.get(
        BaseUrlLocal.home,
      );
      debugPrint('Home : ${homeResponseData.data}');
      homeResponse = HomeResponse.fromJson(homeResponseData.data);
      homeData = homeResponse.data?.home!;
      gridHomeData = [
        HomeGrid(
          id: 0,
          title: "Total Produk",
          total: homeData?.totalProduk ?? 0,
          isPrice: false,
          icon: FaIcon(
            FontAwesomeIcons.boxesStacked,
            color: AppColors.background1,
            size: 3.5.w,
          ),
        ),
        HomeGrid(
          id: 1,
          title: "Total Kategori",
          total: homeData?.totalKategori ?? 0,
          isPrice: false,
          icon: FaIcon(
            FontAwesomeIcons.box,
            color: AppColors.background1,
            size: 3.5.w,
          )
        ),
        HomeGrid(
          id: 2,
          title: "Total Supplier",
          total: homeData?.totalSupplier ?? 0,
          isPrice: false,
          icon: FaIcon(
            FontAwesomeIcons.truck,
            color: AppColors.background1,
            size: 3.w,
          )
        ),
        HomeGrid(
          id: 3,
          title: "Total User",
          total: homeData?.totalUser ?? 0,
          isPrice: false,
          icon: FaIcon(
            FontAwesomeIcons.users,
            color: AppColors.background1,
            size: 3.5.w,
          )
        ),
        HomeGrid(
          id: 4,
          title: "Total Penjualan Hari Ini",
          total: homeData?.totalPenjualanHariIni ?? 0,
          isPrice: true,
          icon: FaIcon(
            FontAwesomeIcons.upload,
            color: AppColors.background1,
            size: 3.5.w,
          )
        ),
        HomeGrid(
          id: 5,
          title: "Total Pembelian Hari Ini",
          total: homeData?.totalPembelianHariIni ?? 0,
          isPrice: true,
          icon: FaIcon(
            FontAwesomeIcons.download,
            color: AppColors.background1,
            size: 3.5.w,
          )
        ),
      ];
      update();
    } on DioError catch (error) {
      debugPrint(error.toString());
    }
    isLoading = false;
    update();
  }
}
