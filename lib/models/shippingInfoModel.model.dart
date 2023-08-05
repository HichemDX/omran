class ShippingInfo {
  String? name;
  String? phone;
  String? wilaya;
  String? commune;
  String? address;

  ShippingInfo(
      {this.name, this.phone, this.wilaya, this.commune, this.address});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    print('shipong convert');
    name = json['name'];
    phone = json['phone'];
    wilaya = json['wilaya'];
    commune = json['commune'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['wilaya'] = this.wilaya;
    data['commune'] = this.commune;
    data['address'] = this.address;
    return data;
  }
}
