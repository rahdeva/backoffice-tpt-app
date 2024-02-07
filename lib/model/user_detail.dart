// To parse this JSON data, do
//
//     final userDetailResponse = userDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:backoffice_tpt_app/model/user.dart';

UserDetailResponse userDetailResponseFromJson(String str) => UserDetailResponse.fromJson(json.decode(str));

String userDetailResponseToJson(UserDetailResponse data) => json.encode(data.toJson());

class UserDetailResponse {
    Data? data;
    String? error;

    UserDetailResponse({
        this.data,
        this.error,
    });

    factory UserDetailResponse.fromJson(Map<String, dynamic> json) => UserDetailResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
    };
}

class Data {
    UserData? user;

    Data({
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };
}