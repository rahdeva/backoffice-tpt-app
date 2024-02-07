// To parse this JSON data, do
//
//     final supplierDetailResponse = supplierDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:backoffice_tpt_app/model/supplier.dart';

SupplierDetailResponse supplierDetailResponseFromJson(String str) => SupplierDetailResponse.fromJson(json.decode(str));

String supplierDetailResponseToJson(SupplierDetailResponse data) => json.encode(data.toJson());

class SupplierDetailResponse {
    Data? data;
    String? error;

    SupplierDetailResponse({
        this.data,
        this.error,
    });

    factory SupplierDetailResponse.fromJson(Map<String, dynamic> json) => SupplierDetailResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    Supplier? supplier;

    Data({
        this.supplier,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        supplier: json["supplier"] == null ? null : Supplier.fromJson(json["supplier"]),
    );

    Map<String, dynamic> toJson() => {
        "supplier": supplier?.toJson(),
    };
}