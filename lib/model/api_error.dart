//
//     final apiError = apiErrorFromJson(jsonString);

import 'dart:convert';

import '/model/error_response.dart';

APIError apiErrorFromJson(String str) => APIError.fromJson(json.decode(str));

String apiErrorToJson(APIError data) => json.encode(data.toJson());

class APIError {
    dynamic data;
    ErrorResponse? error;

    APIError({
        this.data,
        this.error,
    });

    factory APIError.fromJson(Map<String, dynamic> json) => APIError(
        data: json["data"],
        error: json["error"] == null ? null : ErrorResponse.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "error": error?.toJson(),
    };
}