// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
    Data? data;
    String? error;

    ProductResponse({
        this.data,
        this.error,
    });

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
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
    List<Product>? product;

    Data({
        this.meta,
        this.product,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        product: json["product"] == null ? [] : List<Product>.from(json["product"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
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

class Product {
    int? productId;
    int? categoryId;
    String? categoryName;
    String? productName;
    int? purchasePrice;
    String? productCode;
    String? brand;
    int? salePrice;
    int? stock;
    int? sold;
    String? image;
    DateTime? createdAt;
    DateTime? updatedAt;

    Product({
        this.productId,
        this.categoryId,
        this.categoryName,
        this.productName,
        this.purchasePrice,
        this.productCode,
        this.brand,
        this.salePrice,
        this.stock,
        this.sold,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        productName: json["product_name"],
        purchasePrice: json["purchase_price"],
        productCode: json["product_code"],
        brand: json["brand"],
        salePrice: json["sale_price"],
        stock: json["stock"],
        sold: json["sold"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "category_id": categoryId,
        "category_name": categoryName,
        "product_name": productName,
        "purchase_price": purchasePrice,
        "product_code": productCode,
        "brand": brand,
        "sale_price": salePrice,
        "stock": stock,
        "sold": sold,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
