// To parse this JSON data, do
//
//     final purchaseResponse = purchaseResponseFromJson(jsonString);

import 'dart:convert';

PurchaseResponse purchaseResponseFromJson(String str) => PurchaseResponse.fromJson(json.decode(str));

String purchaseResponseToJson(PurchaseResponse data) => json.encode(data.toJson());

class PurchaseResponse {
    Data? data;
    String? error;

    PurchaseResponse({
        this.data,
        this.error,
    });

    factory PurchaseResponse.fromJson(Map<String, dynamic> json) => PurchaseResponse(
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
    List<Purchase>? purchase;

    Data({
        this.meta,
        this.purchase,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        purchase: json["purchase"] == null ? [] : List<Purchase>.from(json["purchase"]!.map((x) => Purchase.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "purchase": purchase == null ? [] : List<dynamic>.from(purchase!.map((x) => x.toJson())),
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

class Purchase {
    int? purchaseId;
    int? userId;
    int? supplierId;
    String? userName;
    String? supplierName;
    DateTime? purchaseDate;
    int? totalItem;
    int? totalPrice;
    DateTime? createdAt;
    DateTime? updatedAt;

    Purchase({
        this.purchaseId,
        this.userId,
        this.supplierId,
        this.userName,
        this.supplierName,
        this.purchaseDate,
        this.totalItem,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
    });

    factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        purchaseId: json["purchase_id"],
        userId: json["user_id"],
        supplierId: json["supplier_id"],
        userName: json["user_name"],
        supplierName: json["supplier_name"],
        purchaseDate: json["purchase_date"] == null ? null : DateTime.parse(json["purchase_date"]),
        totalItem: json["total_item"],
        totalPrice: json["total_price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "purchase_id": purchaseId,
        "user_id": userId,
        "supplier_id": supplierId,
        "user_name": userName,
        "supplier_name": supplierName,
        "purchase_date": purchaseDate?.toIso8601String(),
        "total_item": totalItem,
        "total_price": totalPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
