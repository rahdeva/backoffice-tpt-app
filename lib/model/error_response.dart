class ErrorResponse {
    ErrorResponse({
        this.code,
        this.msg,
    });

    int? code;
    String? msg;

    factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        code: json["code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
    };
}