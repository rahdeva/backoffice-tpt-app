// To parse this JSON data, do
//
//     final financialBalanceResponse = financialBalanceResponseFromJson(jsonString);

import 'dart:convert';

FinancialBalanceResponse financialBalanceResponseFromJson(String str) => FinancialBalanceResponse.fromJson(json.decode(str));

String financialBalanceResponseToJson(FinancialBalanceResponse data) => json.encode(data.toJson());

class FinancialBalanceResponse {
    Data? data;
    String? error;

    FinancialBalanceResponse({
        this.data,
        this.error,
    });

    factory FinancialBalanceResponse.fromJson(Map<String, dynamic> json) => FinancialBalanceResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    int? balance;

    Data({
        this.balance,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
    };
}
