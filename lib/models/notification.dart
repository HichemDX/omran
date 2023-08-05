class NotificationModel {
  int? id;
  String? titleAr;
  String? titleFr;
  String? descriptionAr;
  String? descriptionFr;
  String? date;
  int? storeId;
  String? storeImage;
  String? storeName;
  bool? see;
  String? orderId;
  String? createdAt;

  NotificationModel({
    this.id,
    this.titleAr,
    this.titleFr,
    this.date,
    this.storeId,
    this.storeImage,
    this.storeName,
    this.see,
    this.orderId,
    this.createdAt,
    this.descriptionAr,
    this.descriptionFr,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleFr = json['title_fr'];
    descriptionAr = json['description_ar'];
    descriptionFr = json['description_fr'];
    date = json['date'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    see = json['see'];
    storeImage = json['store_image'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_ar'] = titleAr;
    data['title_fr'] = titleFr;
    data['date'] = date;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['see'] = see;
    data['store_image'] = storeImage;

    return data;
  }
}
