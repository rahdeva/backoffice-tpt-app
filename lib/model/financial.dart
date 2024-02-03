// To parse this JSON data, do
//
//     final financialResponse = financialResponseFromJson(jsonString);

import 'dart:convert';

FinancialResponse financialResponseFromJson(String str) => FinancialResponse.fromJson(json.decode(str));

String financialResponseToJson(FinancialResponse data) => json.encode(data.toJson());

class FinancialResponse {
    Data? data;
    String? error;

    FinancialResponse({
        this.data,
        this.error,
    });

    factory FinancialResponse.fromJson(Map<String, dynamic> json) => FinancialResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    List<Financial>? financial;
    Meta? meta;

    Data({
        this.financial,
        this.meta,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        financial: json["financial"] == null ? [] : List<Financial>.from(json["financial"]!.map((x) => Financial.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "financial": financial == null ? [] : List<dynamic>.from(financial!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class Financial {
    int? financialId;
    int? userId;
    String? userName;
    int? type;
    DateTime? financialDate;
    String? information;
    int? cashIn;
    int? cashOut;
    int? balance;
    DateTime? createdAt;
    DateTime? updatedAt;

    Financial({
        this.financialId,
        this.userId,
        this.userName,
        this.type,
        this.financialDate,
        this.information,
        this.cashIn,
        this.cashOut,
        this.balance,
        this.createdAt,
        this.updatedAt,
    });

    factory Financial.fromJson(Map<String, dynamic> json) => Financial(
        financialId: json["financial_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        type: json["type"],
        financialDate: json["financial_date"] == null ? null : DateTime.parse(json["financial_date"]),
        information: json["information"],
        cashIn: json["cash_in"],
        cashOut: json["cash_out"],
        balance: json["balance"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "financial_id": financialId,
        "user_id": userId,
        "user_name": userName,
        "type": type,
        "financial_date": financialDate?.toIso8601String(),
        "information": information,
        "cash_in": cashIn,
        "cash_out": cashOut,
        "balance": balance,
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
