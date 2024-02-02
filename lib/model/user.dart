// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
    Data? data;
    String? error;

    UserResponse({
        this.data,
        this.error,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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

class UserData {
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

    UserData({
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

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
