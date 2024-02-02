// To parse this JSON data, do
//
//     final saleResponse = saleResponseFromJson(jsonString);

import 'dart:convert';

SaleResponse saleResponseFromJson(String str) => SaleResponse.fromJson(json.decode(str));

String saleResponseToJson(SaleResponse data) => json.encode(data.toJson());

class SaleResponse {
    Data? data;
    String? error;

    SaleResponse({
        this.data,
        this.error,
    });

    factory SaleResponse.fromJson(Map<String, dynamic> json) => SaleResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    Meta? meta;
    List<Sale>? sale;

    Data({
        this.meta,
        this.sale,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        sale: json["sale"] == null ? [] : List<Sale>.from(json["sale"]!.map((x) => Sale.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "sale": sale == null ? [] : List<dynamic>.from(sale!.map((x) => x.toJson())),
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

class Sale {
    int? saleId;
    int? userId;
    String? userName;
    DateTime? saleDate;
    int? totalItem;
    int? totalPrice;
    DateTime? createdAt;
    DateTime? updatedAt;

    Sale({
        this.saleId,
        this.userId,
        this.userName,
        this.saleDate,
        this.totalItem,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
    });

    factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        saleId: json["sale_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        saleDate: json["sale_date"] == null ? null : DateTime.parse(json["sale_date"]),
        totalItem: json["total_item"],
        totalPrice: json["total_price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "sale_id": saleId,
        "user_id": userId,
        "user_name": userName,
        "sale_date": saleDate?.toIso8601String(),
        "total_item": totalItem,
        "total_price": totalPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
