// To parse this JSON data, do
//
//     final financialType = financialTypeFromJson(jsonString);

import 'dart:convert';

List<FinancialType> financialTypeFromJson(String str) => List<FinancialType>.from(json.decode(str).map((x) => FinancialType.fromJson(x)));

String financialTypeToJson(List<FinancialType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinancialType {
    int? typeId;
    String? typeName;

    FinancialType({
        this.typeId,
        this.typeName,
    });

    factory FinancialType.fromJson(Map<String, dynamic> json) => FinancialType(
        typeId: json["type_id"],
        typeName: json["type_name"],
    );

    Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "type_name": typeName,
    };
}
