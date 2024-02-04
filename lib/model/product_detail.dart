// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:backoffice_tpt_app/model/product.dart';

ProductDetailResponse productDetailResponseFromJson(String str) => ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) => json.encode(data.toJson());

class ProductDetailResponse {
    Data? data;
    String? error;

    ProductDetailResponse({
        this.data,
        this.error,
    });

    factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    Product? product;

    Data({
        this.product,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
    };
}