class Category {
  int? id;
  String? nameAr;
  String? nameFr;
  int? parent;
  String? icon;

  Category({this.id, this.nameAr, this.nameFr, this.parent, this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    print("convert categorys");
    return Category(
      id: int.parse(json["id"].toString()),
      nameAr: json['name_ar'],
      nameFr: json['name_fr'],
      icon: json['icon'],
      parent: int.parse(json["parent"].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_fr'] = nameFr;
    data['parent'] = parent;
    data['icon'] = icon;
    return data;
  }
}
