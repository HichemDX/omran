// To parse this JSON data, do
//
//     final commune = communeFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Commune> communeFromJson(String str) =>
    List<Commune>.from(json.decode(str).map((x) => Commune.fromJson(x)));

String communeToJson(List<Commune> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commune extends Equatable {
  Commune({
    this.id,
    this.wilayaId,
    this.nameAr,
    this.nameFr,
  });

  int? id;
  int? wilayaId;
  String? nameAr;
  String? nameFr;

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        id: json["id"],
        wilayaId: json["wilaya_id"],
        nameAr: json["name_ar"],
        nameFr: json["name_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wilaya_id": wilayaId,
        "name_ar": nameAr,
        "name_fr": nameFr,
      };

  @override
  List<Object?> get props => [id];
}
