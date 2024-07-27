import 'package:html/parser.dart';
import 'package:teleprac/core/const/links.dart';

class ProductModel {
  String? id;
  String? userId;
  String? name;
  String? slug;
  String? category;
  String? subcategory;
  String? unitValue;
  String? unit;
  String? price;
  String? salePrice;
  String? discount;
  String? description;
  String? shortDescription;
  String? manufacturedBy;
  String? medicineType;
  String? uploadImageUrl;
  String? uploadPreviewImageUrl;
  String? createdDate;
  String? stockStatus;
  String? composition;
  String? status;
  String? featured;
  String? expiryDate;
  String? oldPId;
  String? savedImage;
  ProductModel({
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.category,
    this.subcategory,
    this.unitValue,
    this.unit,
    this.price,
    this.salePrice,
    this.discount,
    this.description,
    this.shortDescription,
    this.manufacturedBy,
    this.medicineType,
    this.uploadImageUrl,
    this.uploadPreviewImageUrl,
    this.createdDate,
    this.stockStatus,
    this.composition,
    this.status,
    this.featured,
    this.expiryDate,
    this.oldPId,
    this.savedImage,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    savedImage = json['lastProductImage'].toString();
    id = json['id'].toString();
    userId = json['user_id'].toString();
    name = json['name'].toString();
    slug = json['slug'].toString();
    category = json['category'].toString();
    subcategory = json['subcategory'].toString();
    unitValue = json['unit_value'].toString();
    unit = json['unit'].toString();
    price = json['price'].toString().split('.')[0];
    salePrice = json['sale_price'].toString().split('.')[0];
    discount = json['discount'].toString();
    description = parse(json['description'].toString()).body?.text;
    shortDescription = parse(json['short_description'].toString()).body?.text;
    manufacturedBy = json['manufactured_by'].toString();
    medicineType = json['medicine_type'].toString();
    uploadImageUrl = savedImage.toString() == 'null'
        ? '${AppLinks.baseUrl}/${json['upload_image_url'].toString()}'
        : null;
    uploadPreviewImageUrl =
        '${AppLinks.baseUrl}/${json['upload_preview_image_url'].toString()}';
    createdDate = json['created_date'].toString();
    stockStatus = json['stock_status'].toString();
    composition = json['composition'].toString();
    status = json['status'].toString();
    featured = json['featured'].toString();
    expiryDate = json['expiry_date'].toString();
    oldPId = json['old_p_id'].toString();
  }
}
