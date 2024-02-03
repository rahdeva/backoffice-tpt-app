// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
    Data? data;
    String? error;

    HomeResponse({
        this.data,
        this.error,
    });

    factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    Home? home;

    Data({
        this.home,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        home: json["home"] == null ? null : Home.fromJson(json["home"]),
    );

    Map<String, dynamic> toJson() => {
        "home": home?.toJson(),
    };
}

class Home {
    int? totalProduk;
    int? totalKategori;
    int? totalSupplier;
    int? totalUser;
    int? totalPenjualanHariIni;
    int? totalPembelianHariIni;

    Home({
        this.totalProduk,
        this.totalKategori,
        this.totalSupplier,
        this.totalUser,
        this.totalPenjualanHariIni,
        this.totalPembelianHariIni,
    });

    factory Home.fromJson(Map<String, dynamic> json) => Home(
        totalProduk: json["total_produk"],
        totalKategori: json["total_kategori"],
        totalSupplier: json["total_supplier"],
        totalUser: json["total_user"],
        totalPenjualanHariIni: json["total_penjualan_hari_ini"],
        totalPembelianHariIni: json["total_pembelian_hari_ini"],
    );

    Map<String, dynamic> toJson() => {
        "total_produk": totalProduk,
        "total_kategori": totalKategori,
        "total_supplier": totalSupplier,
        "total_user": totalUser,
        "total_penjualan_hari_ini": totalPenjualanHariIni,
        "total_pembelian_hari_ini": totalPembelianHariIni,
    };
}
