// To parse this JSON data, do
//
//     final financialReportDetailResponse = financialReportDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:backoffice_tpt_app/model/financial.dart';

FinancialReportDetailResponse financialReportDetailResponseFromJson(String str) => FinancialReportDetailResponse.fromJson(json.decode(str));

String financialReportDetailResponseToJson(FinancialReportDetailResponse data) => json.encode(data.toJson());

class FinancialReportDetailResponse {
    Data? data;
    String? error;

    FinancialReportDetailResponse({
        this.data,
        this.error,
    });

    factory FinancialReportDetailResponse.fromJson(Map<String, dynamic> json) => FinancialReportDetailResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    Financial? financial;

    Data({
        this.financial,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        financial: json["financial"] == null ? null : Financial.fromJson(json["financial"]),
    );

    Map<String, dynamic> toJson() => {
        "financial": financial?.toJson(),
    };
}