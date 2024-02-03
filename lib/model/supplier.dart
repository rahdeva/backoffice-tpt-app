// To parse this JSON data, do
//
//     final supplierResponse = supplierResponseFromJson(jsonString);

import 'dart:convert';

SupplierResponse supplierResponseFromJson(String str) => SupplierResponse.fromJson(json.decode(str));

String supplierResponseToJson(SupplierResponse data) => json.encode(data.toJson());

class SupplierResponse {
    Data? data;
    String? error;

    SupplierResponse({
        this.data,
        this.error,
    });

    factory SupplierResponse.fromJson(Map<String, dynamic> json) => SupplierResponse(
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
    List<Supplier>? supplier;

    Data({
        this.meta,
        this.supplier,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        supplier: json["supplier"] == null ? [] : List<Supplier>.from(json["supplier"]!.map((x) => Supplier.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "supplier": supplier == null ? [] : List<dynamic>.from(supplier!.map((x) => x.toJson())),
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

class Supplier {
    int? supplierId;
    String? supplierName;
    String? phoneNumber;
    String? address;
    DateTime? createdAt;
    DateTime? updatedAt;

    Supplier({
        this.supplierId,
        this.supplierName,
        this.phoneNumber,
        this.address,
        this.createdAt,
        this.updatedAt,
    });

    factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        supplierId: json["supplier_id"],
        supplierName: json["supplier_name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "supplier_id": supplierId,
        "supplier_name": supplierName,
        "phone_number": phoneNumber,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
