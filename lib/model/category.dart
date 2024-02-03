// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
    Data? data;
    String? error;

    CategoryResponse({
        this.data,
        this.error,
    });

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    List<Category>? category;
    Meta? meta;

    Data({
        this.category,
        this.meta,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        category: json["category"] == null ? [] : List<Category>.from(json["category"]!.map((x) => Category.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class Category {
    int? categoryId;
    String? categoryName;
    String? categoryCode;
    String? categoryColor;
    DateTime? createdAt;
    DateTime? updatedAt;

    Category({
        this.categoryId,
        this.categoryName,
        this.categoryCode,
        this.categoryColor,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryCode: json["category_code"],
        categoryColor: json["category_color"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_code": categoryCode,
        "category_color": categoryColor,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Meta {
    int? limit;
    int? page;
    int? totalPage;
    int? totalItems;

    Meta({
        this.limit,
        this.page,
        this.totalPage,
        this.totalItems,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        limit: json["limit"],
        page: json["page"],
        totalPage: json["total_page"],
        totalItems: json["total_items"],
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "page": page,
        "total_page": totalPage,
        "total_items": totalItems,
    };
}
