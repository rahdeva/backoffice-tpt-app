// To parse this JSON data, do
//
//     final roleResponse = roleResponseFromJson(jsonString);

import 'dart:convert';

RoleResponse roleResponseFromJson(String str) => RoleResponse.fromJson(json.decode(str));

String roleResponseToJson(RoleResponse data) => json.encode(data.toJson());

class RoleResponse {
    Data? data;
    String? error;

    RoleResponse({
        this.data,
        this.error,
    });

    factory RoleResponse.fromJson(Map<String, dynamic> json) => RoleResponse(
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
    List<Role>? role;

    Data({
        this.meta,
        this.role,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        role: json["role"] == null ? [] : List<Role>.from(json["role"]!.map((x) => Role.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "role": role == null ? [] : List<dynamic>.from(role!.map((x) => x.toJson())),
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

class Role {
    int? roleId;
    String? roleName;
    DateTime? createdAt;
    DateTime? updatedAt;

    Role({
        this.roleId,
        this.roleName,
        this.createdAt,
        this.updatedAt,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["role_id"],
        roleName: json["role_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "role_name": roleName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
