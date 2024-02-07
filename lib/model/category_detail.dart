// To parse this JSON data, do
//
//     final categoryDetailResponse = categoryDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:backoffice_tpt_app/model/category.dart';

CategoryDetailResponse categoryDetailResponseFromJson(String str) => CategoryDetailResponse.fromJson(json.decode(str));

String categoryDetailResponseToJson(CategoryDetailResponse data) => json.encode(data.toJson());

class CategoryDetailResponse {
    Data? data;
    String? error;

    CategoryDetailResponse({
        this.data,
        this.error,
    });

    factory CategoryDetailResponse.fromJson(Map<String, dynamic> json) => CategoryDetailResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    Category? category;

    Data({
        this.category,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
    };
}