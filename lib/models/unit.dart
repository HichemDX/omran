class Unit {
  int? id;
  String? nameAr;
  String? nameFr;

  Unit({this.id,this.nameAr, this.nameFr});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameFr = json['name_fr'];
  }

}
