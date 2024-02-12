// To parse this JSON data, do
//
//     final purchaseDetailResponse = purchaseDetailResponseFromJson(jsonString);

import 'dart:convert';

PurchaseDetailResponse purchaseDetailResponseFromJson(String str) => PurchaseDetailResponse.fromJson(json.decode(str));

String purchaseDetailResponseToJson(PurchaseDetailResponse data) => json.encode(data.toJson());

class PurchaseDetailResponse {
    Data? data;
    String? error;

    PurchaseDetailResponse({
        this.data,
        this.error,
    });

    factory PurchaseDetailResponse.fromJson(Map<String, dynamic> json) => PurchaseDetailResponse(
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
    List<PurchaseDetail>? purchaseDetail;
    int? purchaseId;

    Data({
        this.meta,
        this.purchaseDetail,
        this.purchaseId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        purchaseDetail: json["purchase_detail"] == null ? [] : List<PurchaseDetail>.from(json["purchase_detail"]!.map((x) => PurchaseDetail.fromJson(x))),
        purchaseId: json["purchase_id"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "purchase_detail": purchaseDetail == null ? [] : List<dynamic>.from(purchaseDetail!.map((x) => x.toJson())),
        "purchase_id": purchaseId,
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

class PurchaseDetail {
    int? purchaseDetailId;
    int? purchaseId;
    int? productId;
    String? productCode;
    String? productName;
    int? purchasePrice;
    int? quantity;
    int? subtotal;
    DateTime? createdAt;
    DateTime? updatedAt;

    PurchaseDetail({
        this.purchaseDetailId,
        this.purchaseId,
        this.productId,
        this.productCode,
        this.productName,
        this.purchasePrice,
        this.quantity,
        this.subtotal,
        this.createdAt,
        this.updatedAt,
    });

    factory PurchaseDetail.fromJson(Map<String, dynamic> json) => PurchaseDetail(
        purchaseDetailId: json["purchase_detail_id"],
        purchaseId: json["purchase_id"],
        productId: json["product_id"],
        productCode: json["product_code"],
        productName: json["product_name"],
        purchasePrice: json["purchase_price"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "purchase_detail_id": purchaseDetailId,
        "purchase_id": purchaseId,
        "product_id": productId,
        "product_code": productCode,
        "product_name": productName,
        "purchase_price": purchasePrice,
        "quantity": quantity,
        "subtotal": subtotal,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
