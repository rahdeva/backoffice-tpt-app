// To parse this JSON data, do
//
//     final allUserResponse = allUserResponseFromJson(jsonString);

import 'dart:convert';

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
    List<AllUser>? user;

    Data({
        this.meta,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        user: json["user"] == null ? [] : List<AllUser>.from(json["user"]!.map((x) => AllUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "all_user": user == null ? [] : List<dynamic>.from(user!.map((x) => x.toJson())),
    };
}

class AllUser {
    int? userId;
    int? roleId;
    String? roleName;
    String? uid;
    String? name;
    String? email;
    String? address;
    String? phoneNumber;
    String? profilePicture;
    DateTime? createdAt;
    DateTime? updatedAt;

    AllUser({
        this.userId,
        this.roleId,
        this.roleName,
        this.uid,
        this.name,
        this.email,
        this.address,
        this.phoneNumber,
        this.profilePicture,
        this.createdAt,
        this.updatedAt,
    });

    factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        userId: json["user_id"],
        roleId: json["role_id"],
        roleName: json["role_name"],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        profilePicture: json["profile_picture"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role_id": roleId,
        "role_name": roleName,
        "uid": uid,
        "name": name,
        "email": email,
        "address": address,
        "phone_number": phoneNumber,
        "profile_picture": profilePicture,
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
