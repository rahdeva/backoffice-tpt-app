// To parse this JSON data, do
//
//     final allUserResponse = allUserResponseFromJson(jsonString);

import 'dart:convert';

import 'package:backoffice_tpt_app/model/user.dart';

AllUserResponse allUserResponseFromJson(String str) => AllUserResponse.fromJson(json.decode(str));

String allUserResponseToJson(AllUserResponse data) => json.encode(data.toJson());

class AllUserResponse {
    Data? data;
    String? error;

    AllUserResponse({
        this.data,
        this.error,
    });

    factory AllUserResponse.fromJson(Map<String, dynamic> json) => AllUserResponse(
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
    List<UserData>? user;

    Data({
        this.meta,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        user: json["user"] == null ? [] : List<UserData>.from(json["user"]!.map((x) => UserData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "all_user": user == null ? [] : List<dynamic>.from(user!.map((x) => x.toJson())),
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
