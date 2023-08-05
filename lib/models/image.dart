class ProductImage {
  int id;
  String link ;

  ProductImage({required this.id,required this.link});

  factory ProductImage.fromJson(json){
    return ProductImage(id: json['id'], link: json['name']);
  }
}