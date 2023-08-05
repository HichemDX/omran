import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/product.dart';

class ProductHomeModel {
  Category category;
  List<Product> products = [];

  ProductHomeModel({required this.category, required this.products});

  factory ProductHomeModel.fromJson(json) {
    print("convert client_home_page ");
    return ProductHomeModel(
        category: Category.fromJson(json['category']),
        products: (json['products'] as List).length > 0
            ? (json['products'] as List)
                .map((i) => Product.fromJson(i))
                .toList()
            : []);
  }
}
