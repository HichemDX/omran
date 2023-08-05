
import 'package:bnaa/models/product.dart';

class Cart {
  int? storeId;
  String? storeName;
  String? storeLogo;
  List<Product>? listProducts;

  Cart(
      {this.storeId,this.storeName,this.storeLogo,this.listProducts});

  Cart.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeLogo = json['store_logo'];
    if (json['products'] != null) {
      listProducts = <Product>[];
      json['products'].forEach((v) {
        listProducts!.add( Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_logo'] = storeLogo;
    if (listProducts != null) {
      data['products'] =
            listProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



