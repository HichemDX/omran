class ProductDetailModel {
  int? id;
  String? name;
  num? price;
  String? unitAr;
  String? unitFr;
  int? storeId;
  int? quantity;
  String? desc;
  int? quanitite;
  int? quanititeMinimum;
  String? productImage;
  List<String>? images;

  ProductDetailModel(
      {this.id,
      this.name,
      this.price,
      this.unitAr,
      this.unitFr,
      this.storeId,
      this.quantity,
      this.desc,
      this.quanitite,
      this.quanititeMinimum,
      this.productImage,
      this.images});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = num.tryParse(json['price'].toString());
    unitAr = json['unit_ar'];
    unitFr = json['unit_fr'];
    storeId = json['store_id'];
    quantity = json['quantity'];
    desc = json['desc'];
    quanitite = json['quanitite'];
    quanititeMinimum = json['quanitite_minimum'];
    productImage = json['product_image'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['unit_ar'] = this.unitAr;
    data['unit_fr'] = this.unitFr;
    data['store_id'] = this.storeId;
    data['quantity'] = this.quantity;
    data['desc'] = this.desc;
    data['quanitite'] = this.quanitite;
    data['quanitite_minimum'] = this.quanititeMinimum;
    data['product_image'] = this.productImage;
    data['images'] = this.images;
    return data;
  }
}
