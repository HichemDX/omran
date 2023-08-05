import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/slider.dart';
import 'package:bnaa/view_models/product_home_model.dart';


class HomeViewModel {
  List<HomeSlider> homeSlider = [];
  List<Category> categories = [];
  List<ProductHomeModel> productsByCategories = [];
 // List<DeliveryWilaya> deliveryWilayas = [];

  HomeViewModel({
    required this.homeSlider,
    required this.categories,
    required this.productsByCategories,
    //required this.deliveryWilayas,
  });
}
