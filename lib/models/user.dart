import 'dart:convert';

import 'package:bnaa/models/commune.dart';
import 'package:bnaa/models/wilaya.dart';

class User {
  String? name;
  String? email;
  String? pictureLink;
  String? phone;
  Wilaya? wilaya;
  Commune? commune;
  String? address;
  bool? isClient;
  bool? validated;

  User({
    this.name,
    this.email,
    this.pictureLink,
    this.phone,
    this.wilaya,
    this.commune,
    this.address,
    this.isClient,
    this.validated,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pictureLink': pictureLink,
      'phone': phone,
      "email": email,
      "isClient": isClient,
      "validated": validated,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    print('user convert');
    return User(
      name: map['name'],
      email: map['email'],
      pictureLink: map['image'],
      phone: map['phone'],
      address: map['address'],
      commune: map['commune'] != null ? Commune.fromJson(map['commune']) : null,
      wilaya: map['wilaya'] != null ? Wilaya.fromJson(map['wilaya']) : null,
      isClient: map['isClient'],
      validated: map['validated'],
    );
  }

  String toJson() => json.encode(toMap());
}
