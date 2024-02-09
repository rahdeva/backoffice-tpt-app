// To parse this JSON data, do
//
//     final balanceResponse = balanceResponseFromJson(jsonString);

import 'dart:convert';

BalanceResponse balanceResponseFromJson(String str) => BalanceResponse.fromJson(json.decode(str));

String balanceResponseToJson(BalanceResponse data) => json.encode(data.toJson());

class BalanceResponse {
    Data? data;
    String? error;

    BalanceResponse({
        this.data,
        this.error,
    });

    factory BalanceResponse.fromJson(Map<String, dynamic> json) => BalanceResponse(
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
