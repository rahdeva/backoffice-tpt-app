// To parse this JSON data, do
//
//     final roleDetailResponse = roleDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:backoffice_tpt_app/model/role.dart';

RoleDetailResponse roleDetailResponseFromJson(String str) => RoleDetailResponse.fromJson(json.decode(str));

String roleDetailResponseToJson(RoleDetailResponse data) => json.encode(data.toJson());

class RoleDetailResponse {
    Data? data;
    String? error;

    RoleDetailResponse({
        this.data,
        this.error,
    });

    factory RoleDetailResponse.fromJson(Map<String, dynamic> json) => RoleDetailResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    Role? role;

    Data({
        this.role,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "role": role?.toJson(),
    };
}