// To parse this JSON data, do
//
//     final barangResponse = barangResponseFromJson(jsonString);

import 'dart:convert';

BarangResponse barangResponseFromJson(String str) => BarangResponse.fromJson(json.decode(str));

String barangResponseToJson(BarangResponse data) => json.encode(data.toJson());

class BarangResponse {
    int? status;
    String? message;
    List<Barang>? data;

    BarangResponse({
        this.status,
        this.message,
        this.data,
    });

    factory BarangResponse.fromJson(Map<String, dynamic> json) => BarangResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Barang>.from(json["data"]!.map((x) => Barang.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Barang {
    int? id;
    String? kodeBarang;
    String? namaBarang;

    Barang({
        this.id,
        this.kodeBarang,
        this.namaBarang,
    });

    factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        id: json["id"],
        kodeBarang: json["kode_barang"],
        namaBarang: json["nama_barang"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kode_barang": kodeBarang,
        "nama_barang": namaBarang,
    };
}
