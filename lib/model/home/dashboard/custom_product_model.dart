import 'package:teleprac/core/const/links.dart';

class CustomProductModel {
  String? id;
  String? qty;
  String? pharmacyCurrency;
  String? pharmacyId;
  String? price;
  String? name;
  String? image;

  CustomProductModel({
    this.id,
    this.qty,
    this.pharmacyCurrency,
    this.pharmacyId,
    this.price,
    this.name,
    this.image,
  });

  CustomProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    pharmacyCurrency = json['pharmacy_currency'];
    pharmacyId = json['pharmacy_id'];
    price = json['price'];
    name = json['name'];
    image = '${AppLinks.baseUrl}/${json['image']}';
  }
}
