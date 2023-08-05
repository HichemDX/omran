class Wilaya {
  int? id;
  String? code;
  String? nameAr;
  String? nameFr;

  Wilaya({this.id, this.code, this.nameAr, this.nameFr});

  Wilaya.fromJson(Map<String, dynamic> json) {
    print("convert wilayua");
    id = json['id'];
    code = json['code'];
    nameAr = json['name_ar'];
    nameFr = json['name_fr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['name_ar'] = nameAr;
    data['name_fr'] = nameFr;
    return data;
  }
}
