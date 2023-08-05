class   InfoAppModel {
  String? phone;
  String? address;
  String? email;
  String? facebook;
  String? instagram;
  String? twitter;

  InfoAppModel(
      {this.phone,
      this.address,
      this.email,
      this.facebook,
      this.instagram,
      this.twitter});

   InfoAppModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    return data;
  }
}
