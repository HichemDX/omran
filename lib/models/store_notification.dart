class StoreNotificationModel {
  int? id;
  String? type;
  String? nameFr;
  String? nameAr;
  String? descriptionFr;
  String? descriptionAr;
  String? read;
  Customer? customer;
  String? orderId;
  String? createdAt;

  StoreNotificationModel(
      {this.id,
      this.type,
      this.nameFr,
      this.nameAr,
      this.descriptionFr,
      this.descriptionAr,
      this.read,
      this.customer,
      this.orderId,
      this.createdAt});

  StoreNotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    nameFr = json['name_fr'];
    nameAr = json['name_ar'];
    descriptionFr = json['description_fr'];
    descriptionAr = json['description_ar'];
    read = json['read'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    orderId = json['order_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name_fr'] = nameFr;
    data['name_ar'] = nameAr;
    data['description_fr'] = descriptionFr;
    data['description_ar'] = descriptionAr;
    data['read'] = read;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['order_id'] = orderId;
    data['created_at'] = createdAt;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? provider;
  String? providerId;
  String? fcmToken;
  String? key;
  String? phone;
  String? communeId;
  String? address;
  Null? longitude;
  Null? latitude;
  String? image;
  String? ban;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.provider,
      this.providerId,
      this.fcmToken,
      this.key,
      this.phone,
      this.communeId,
      this.address,
      this.longitude,
      this.latitude,
      this.image,
      this.ban,
      this.rememberToken,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    provider = json['provider'];
    providerId = json['provider_id'];
    fcmToken = json['fcm_token'];
    key = json['key'];
    phone = json['phone'];
    communeId = json['commune_id'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
    ban = json['ban'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['provider'] = provider;
    data['provider_id'] = providerId;
    data['fcm_token'] = fcmToken;
    data['key'] = key;
    data['phone'] = phone;
    data['commune_id'] = communeId;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['image'] = image;
    data['ban'] = ban;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
