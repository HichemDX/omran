import 'package:bnaa/models/commune.dart';
import 'package:bnaa/models/wilaya.dart';

class InfoPersonelModel {
  int? id;
  String? name;
  String? phone;
  String? image;
  bool? ban;
  String? route;
  String? longitude;
  String? latitude;
  String? fcm;
  String? token;
  Wilaya? wilaya;
  Commune? commune;

  InfoPersonelModel(
      {this.id,
      this.name,
      this.phone,
      this.image,
      this.ban,
      this.wilaya,
      this.commune,
      this.route,
      this.longitude,
      this.latitude,
      this.fcm,
      this.token});

  InfoPersonelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    ban = json['ban'];
    route = json['route'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    fcm = json['fcm'];
    token = json['token'];
    wilaya = json['wilaya'];
    commune = json['commune'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['ban'] = this.ban;
    data['route'] = this.route;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['fcm'] = this.fcm;
    data['token'] = this.token;
    data['wilaya'] = this.wilaya;
    data['commune'] = this.commune; 
    return data;
  }
}
