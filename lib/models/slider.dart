class HomeSlider {
  int id;
  String? name;
  String? image;
  String? link;

  HomeSlider({required this.id, this.name, this.image, required this.link});

  factory HomeSlider.fromJson(Map<String, dynamic> json) {
    return HomeSlider(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        link: json['link']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['link'] = link;
    return data;
  }
}
