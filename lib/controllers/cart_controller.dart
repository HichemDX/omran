import 'dart:convert';

import 'package:bnaa/models/cart.dart';
import 'package:bnaa/models/delivery.dart';
import 'package:bnaa/models/product.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  Map<String, Cart> cartsMap = {};

  bool isDeliverable = false;
  num deliveryPrice = 0;

  void setDeliverability(bool newValue, [num price = 0.0]) {
    isDeliverable = newValue;
    deliveryPrice = price;
    update();
  }

  Future<bool> loadFromStorage() async {
    try {
      cartsMap.clear();
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString('cart') != null) {
        Map<String, dynamic> _myJson = jsonDecode(pref.getString('cart')!);
        print(_myJson);

        Map<String, Map<String, dynamic>> json = {};
        _myJson.forEach((key, value) {
          print('value  :  $value');

          Cart cart = Cart(
            storeId: value['store_id'],
            storeName: value['store_name'],
            storeLogo: value['store_logo'],
            listProducts: (value['products'] as List).map((e) {
              Product product = Product.fromJson(e);
              product.deliveryWilayas = (e['delivery_wilayas'] as List)
                  .map((e) => DeliveryWilaya.fromJson(e))
                  .toList();
              return product;
            }).toList(),
          );
          print('cart : ${cart.toJson()}');
          json.addAll({key: cart.toJson()});
        });

        json.forEach((key, value) {
          if (cartsMap[key] != null) {
            print(value['store_id']);
            cartsMap[key]!.listProducts =
                (value['products'] as List<Map<String, dynamic>>)
                    .map((Map<String, dynamic> i) => Product.fromJson(i))
                    .toList();
          } else {
            print('rani f else');
            cartsMap.addAll({key: Cart.fromJson(value)});
          }
        });
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
    return true;
  }

  addToCart({storeId, storeName, storeImage, product}) async {
    await loadFromStorage();
    if (cartsMap['$storeId'] != null) {
      cartsMap['$storeId']!.listProducts!.add(product);
    } else {
      cartsMap.addAll({
        storeId: Cart(
          storeId: int.parse(storeId),
          storeName: storeName,
          storeLogo: storeImage,
          listProducts: [product],
        )
      });
    }
    await save();
    update();
  }

  removeProduct({storeId, productIndex}) async {
    cartsMap['$storeId']!.listProducts!.removeAt(productIndex);
    if (cartsMap['$storeId']!.listProducts!.isEmpty) {
      await removeCart(storeId: storeId);
    } else {
      await save();
      update();
    }
  }

  removeCart({storeId}) async {
    cartsMap.removeWhere((key, value) => key == storeId.toString());
    await save();
    update();
  }

  updateProductQantity(storeId, productIndex, int number) async {
    Product product = cartsMap['$storeId']!.listProducts![productIndex];
    product.qtySelect = product.qtySelect! + double.parse(number.toString());

    await save();
    update();
  }

  save() async {
    Map<String, Map<String, dynamic>> _myCarts = {};
    cartsMap.forEach((key, value) {
      _myCarts.addAll({
        key: value.toJson(),
      });
    });
    SharedPreferences storage = await SharedPreferences.getInstance();
    // await storage.setString('cart', json.encode(cartsMap));
    await storage.setString('cart', json.encode(_myCarts));
  }
  
}
