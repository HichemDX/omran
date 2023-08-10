import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/shippingInfoModel.model.dart';
import 'package:bnaa/models/user.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.storeId,
    this.storeName,
    this.storeLogo,
    this.code,
    this.shippingCost,
    this.grandTotal,
    this.status,
    this.createdAt,
    this.customer,
    this.shippingInfo,
    this.listProducts,
  });

  int? id;
  int? storeId;
  String? storeName;
  String? storeLogo;
  String? code;
  String? shippingCost;
  String? grandTotal;
  String? status;
  String? createdAt;
  CustomUser? customer;
  ShippingInfo? shippingInfo;
  List<Product>? listProducts;

  factory Order.fromJson(Map<String, dynamic> json) {
    print("order convert");
    return Order(
      id: int.parse(json["id"].toString()),
      storeId: int.parse(json["store_id"].toString()),
      storeName: json["store_name"],
      storeLogo: json["store_logo"],
      code: json["code"],
      shippingCost: json["shipping_cost"],
      grandTotal: json["grand_total"],
      status: json["status"],
      createdAt: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(json["created_at"])),
      customer: CustomUser.fromJson(json["customer"]?? {}),
      shippingInfo: ShippingInfo.fromJson(json["shipping_info"]),
      listProducts: List<Product>.from(
          json["list_products"].map((x) => Product.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "store_name": storeName,
        "store_logo": storeLogo,
        "code": code,
        "shipping_cost": shippingCost,
        "grand_total": grandTotal,
        "status": status,
        "created_at": createdAt!,
        "customer": customer!.toJson(),
        "shipping_info": shippingInfo!.toJson(),
        "list_products":
            List<dynamic>.from(listProducts!.map((x) => x.toJson())),
      };
}
