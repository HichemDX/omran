import 'package:bnaa/models/product.dart';
class ListCommandModel {
  int? storeId;
  String? storeName;
  String? storeLogo;
  bool? delivery;
  List<Product>? listProducts;
ListCommandModel(
      {this.storeId,
      this.delivery,
      this.storeName,
      this.storeLogo,
      this.listProducts});
ListCommandModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    delivery = json['delivery'];
    storeName = json['store_name'];
    storeLogo = json['store_logo'];
    if (json['list_products'] != null) {
      listProducts = <Product>[];
      json['list_products'].forEach((v) {
        listProducts!.add(new Product.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_logo'] = this.storeLogo;
    if (this.listProducts != null) {
      data['list_products'] =
          this.listProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
