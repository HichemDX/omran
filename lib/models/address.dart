class Address {
  String? wilaya;
  String? commune;
  String? route;

  Address({this.wilaya, this.commune, this.route});

  Address.fromJson(Map<String, dynamic> json) {
    wilaya = json['wilaya'];
    commune = json['commune'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wilaya'] = this.wilaya;
    data['commune'] = this.commune;
    data['route'] = this.route;
    return data;
  }
}
