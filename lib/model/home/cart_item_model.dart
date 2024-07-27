import 'package:teleprac/model/pharmacies/product_model.dart';

class CartItemModel {
  String? id;
  String? userId;
  String? hashedProductId;
  ProductModel? productModel;
  String? qty;
  String? created;

  CartItemModel({
    this.id,
    this.userId,
    this.hashedProductId,
    this.productModel,
    this.qty,
    this.created,
  });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    hashedProductId = json['product_id'];
    qty = json['qty'];
    created = json['created'];
    productModel = json['product_detail'] != null
        ? ProductModel.fromJson(json['product_detail'])
        : null;
        
  }
}
