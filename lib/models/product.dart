import 'package:bnaa/models/image.dart';
import 'package:equatable/equatable.dart';

import 'delivery.dart';

class Product extends Equatable {
  int? id;
  String? name;
  String? address;
  bool? save;
  String? price;
  String? unitAr;
  String? unitFr;
  int? storeId;
  String? storeName;
  String? storeImage;
  String? productImage;
  num? quanititeMinimum;
  List<ProductImage>? images;
  String? desc;
  num? qty;
  num? quantity;
  num? qtySelect = 0;
  int? unitId;
  int? categoryId;
  String? categoryFr;
  String? categoryAr;
  List<DeliveryWilaya> deliveryWilayas = [];

  Product({
    this.id,
    this.name,
    this.address,
    this.qty = 1,
    this.quantity = 1,
    this.desc,
    this.productImage,
    this.save,
    this.price,
    this.unitAr,
    this.unitFr,
    this.storeId,
    this.storeName,
    this.quanititeMinimum,
    this.storeImage,
    this.images,
    this.categoryId,
    this.unitId,
    this.categoryAr,
    this.categoryFr,
    this.qtySelect,
    this.deliveryWilayas = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    print("product convert");

    return Product(
      id: int.parse(json["id"].toString()),
      name: json['name'],
      address: json['address'],
      save: json['save'],
      price: json['price'],
      unitAr: json['unit_ar'],
      unitFr: json['unit_fr'],
      storeId: json['store_id'],
      storeName: json['store_name'],
      storeImage: json['store_image'],
      qty: json["qty"] != null
          ? num.parse(
              json["qty"].toString(),
            )
          : 1,
      quantity: json["quantity"] != null
          ? num.parse(
              json["quantity"].toString(),
            )
          : 1,
      qtySelect: json["qty_select"] != null
          ? num.parse(
              json["qty_select"].toString(),
            )
          : 1,
      desc: json['description'],
      quanititeMinimum:
          json["min_qty"] != null ? num.parse(json["min_qty"].toString()) : 1,
      productImage: json['product_image'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((i) => ProductImage.fromJson(i))
              .toList()
          : [],
      categoryId: json['category_id'],
      categoryAr: json['category_Ar'],
      categoryFr: json['category_Fr'],
      unitId: json['unite_id'],
      deliveryWilayas: json['delivery_wilayas'] == null
          ? []
          : (json['delivery_wilayas'] as List)
              .map((e) => DeliveryWilaya.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['save'] = save;
    data['price'] = price;
    data['unit_ar'] = unitAr;
    data['unit_fr'] = unitFr;
    data['quantity'] = qty;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_image'] = storeImage;
    data['qty_select'] = qtySelect;
    data["min_qty"] = quanititeMinimum;
    data['delivery_wilayas'] = deliveryWilayas.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [id];
}
