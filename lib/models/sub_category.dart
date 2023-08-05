
import 'package:bnaa/models/category.dart';

class SubCategory  extends Category {


  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameFr = json['name_fr'];
    parent = json['parent'];
    icon = json['icon'];
  }
  }