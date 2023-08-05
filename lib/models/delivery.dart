import 'package:bnaa/models/wilaya.dart';
import 'package:equatable/equatable.dart';

import 'commune.dart';

class DeliveryWilaya {
  Wilaya wilaya;

  num defaultPrice;

  List<DeliveryCommune>? communes;

  DeliveryWilaya({
    required this.wilaya,
    required this.defaultPrice,
    this.communes,
  });

  factory DeliveryWilaya.fromJson(Map<String, dynamic> json) {
    List<DeliveryCommune> communes = (json['communes'] as List)
        .map((e) => DeliveryCommune.fromJson(e))
        .toList();
    communes = communes.where((element) => false).toList();

    return DeliveryWilaya(
      wilaya: Wilaya.fromJson(json),
      defaultPrice: num.parse(json['price']),
      communes: (json['communes'] as List)
          .map((e) => DeliveryCommune.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': defaultPrice.toString(),
      ...wilaya.toJson(),
      if (communes != null)
        'communes': communes!.map((commune) => commune.toJson()).toList()
    };
  }
}

class DeliveryCommune extends Equatable {
  Commune commune;
  num price;

  DeliveryCommune({
    required this.commune,
    required this.price,
  });

  factory DeliveryCommune.fromJson(Map<String, dynamic> json) {
    return DeliveryCommune(
      commune: Commune.fromJson(json),
      price: num.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price.toString(),
      ...commune.toJson(),
    };
  }

  @override
  List<Object?> get props => [commune];
}
