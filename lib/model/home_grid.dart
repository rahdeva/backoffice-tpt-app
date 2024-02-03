import 'package:flutter/material.dart';

class HomeGrid {
  HomeGrid({
    required this.id,
    required this.title,
    required this.total,
    required this.isPrice,
    required this.icon,
  });

  int id;
  String? title;
  int? total;
  bool? isPrice;
  Widget? icon;

  factory HomeGrid.fromJson(Map<String, dynamic> json) => HomeGrid(
        id: json["id"],
        title: json["title"] ,
        total: json["total"],
        isPrice: json["isPrice"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "total": total,
        "isPrice": isPrice,
        "icon": icon,
      };
}
