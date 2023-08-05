import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/shippingInfoModel.model.dart';
import 'package:bnaa/models/user.dart';

class CommandDetailModel {
  int? storeId;
  String? storeName;
  String? storeLogo;
  String? code;
  double? shippingCost;
  double? grandTotal;
  String? status;
  String? createdAt;
  User? customer;
  ShippingInfo? shippingInfo;
  List<Product>? listProducts;

  CommandDetailModel(
      {this.storeId,
      this.storeName,
      this.storeLogo,
      this.code,
      this.shippingCost,
      this.grandTotal,
      this.status,
      this.createdAt,
      this.customer,
      this.shippingInfo,
      this.listProducts});

  CommandDetailModel.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeLogo = json['store_logo'];
    code = json['code'];
    shippingCost = json['shipping_cost'];
    grandTotal = json['grand_total'];
    status = json['status'];
    createdAt = json['created_at'];
    customer = json['customer'] != null
        ? new User.fromJson(json['customer'])
        : null;
    shippingInfo = json['shipping_info'] != null
        ? new ShippingInfo.fromJson(json['shipping_info'])
        : null;
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
    data['code'] = this.code;
    data['shipping_cost'] = this.shippingCost;
    data['grand_total'] = this.grandTotal;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.shippingInfo != null) {
      data['shipping_info'] = this.shippingInfo!.toJson();
    }
    if (this.listProducts != null) {
      data['list_products'] =
          this.listProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



