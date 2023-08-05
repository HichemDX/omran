import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/commune.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/wilaya.dart';

class Store {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  Wilaya? wilaya;
  Commune? commune;
  String? addres;
  int? distance;
  List<Category>? categories;
  List<Product>? products;
  Store({this.id, this.name,this.email,this.phone, this.image,this.wilaya,this.commune,this.addres, this.distance,this.categories,this.products});

  Store.fromJson(Map<String, dynamic> json) {
    print('store convert');
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    distance = json['distance'];
    addres = json['address'];
    wilaya = json['wilaya'] != null ? Wilaya.fromJson(json['wilaya']): null ;
    commune = json['commune'] != null ? Commune.fromJson(json['commune']): null ;
    categories = json['client_all_categories_page'] != null? (json['client_all_categories_page'] as List)
        .map((i) => Category.fromJson(i))
        .toList()
        : null ;
    products = json['products'] != null? (json['products'] as List)
        .map((i) => Product.fromJson(i))
        .toList()
        : null ;
  }

  get pictureLink => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['distance'] = this.distance;
    return data;
  }
}
