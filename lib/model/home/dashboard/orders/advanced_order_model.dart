class AdvancedOrderModel {
  UserDetails? userDetails;
  List<OrderDetails>? orderDetails;

  AdvancedOrderModel({this.userDetails, this.orderDetails});

  AdvancedOrderModel.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
  }
}

class UserDetails {
  String? orderUserDetailsId;
  String? fullName;
  String? userId;
  String? pharmacyId;
  String? address1;
  String? address2;
  String? state;
  String? email;
  String? postalCode;
  String? status;
  String? city;
  String? country;
  String? paymentMethod;
  String? phoneno;
  String? zipcode;
  String? totalAmount;
  String? createdAt;
  String? currency;
  String? shipping;
  String? pharmacyFirstName;
  String? pharmacyLastName;
  String? pharmacyName;
  String? userMobileno;
  String? qty;
  String? pharCountryname;
  String? pharStatename;
  String? pharCityname;
  String? userAddress1;
  String? userAddress2;
  String? userCountryname;
  String? userStatename;
  String? userCityname;
  String? userPostalCode;

  UserDetails(
      {this.orderUserDetailsId,
      this.fullName,
      this.userId,
      this.pharmacyId,
      this.address1,
      this.address2,
      this.state,
      this.email,
      this.postalCode,
      this.status,
      this.city,
      this.country,
      this.paymentMethod,
      this.phoneno,
      this.zipcode,
      this.totalAmount,
      this.createdAt,
      this.currency,
      this.shipping,
      this.pharmacyFirstName,
      this.pharmacyLastName,
      this.pharmacyName,
      this.userMobileno,
      this.qty,
      this.pharCountryname,
      this.pharStatename,
      this.pharCityname,
      this.userAddress1,
      this.userAddress2,
      this.userCountryname,
      this.userStatename,
      this.userCityname,
      this.userPostalCode});

  UserDetails.fromJson(Map<String, dynamic> json) {
    orderUserDetailsId = json['order_user_details_id'] ?? '';
    fullName = json['full_name'] ?? '';
    userId = json['user_id'] ?? '';
    pharmacyId = json['pharmacy_id'] ?? '';
    address1 = json['address1'] ?? '';
    address2 = json['address2'] ?? '';
    state = json['state'] ?? '';
    email = json['email'] ?? '';
    postalCode = json['postal_code'] ?? '';
    status = json['status'] ?? '';
    city = json['city'] ?? '';
    country = json['country'] ?? '';
    paymentMethod = json['payment_method'] ?? '';
    phoneno = json['phoneno'] ?? '';
    zipcode = json['zipcode'] ?? '';
    totalAmount = json['total_amount'] ?? '';
    createdAt = json['created_at'] ?? '';
    currency = json['currency'] ?? '';
    shipping = json['shipping'] ?? '';
    pharmacyFirstName = json['pharmacy_first_name'] ?? '';
    pharmacyLastName = json['pharmacy_last_name'] ?? '';
    pharmacyName = json['pharmacy_name'] ?? '';
    userMobileno = json['user_mobileno'] ?? '';
    qty = json['qty'] ?? '';
    pharCountryname = json['phar_countryname'] ?? '';
    pharStatename = json['phar_statename'] ?? '';
    pharCityname = json['phar_cityname'] ?? '';
    userAddress1 = json['user_address1'] ?? '';
    userAddress2 = json['user_address2'] ?? '';
    userCountryname = json['user_countryname'] ?? '';
    userStatename = json['user_statename'] ?? '';
    userCityname = json['user_cityname'] ?? '';
    userPostalCode = json['user_postal_code'] ?? '';
  }
}

class OrderDetails {
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
  String? pharmacyId;
  String? orderId;
  String? userOrderId;
  String? productName;
  String? productId;
  String? quantity;
  String? subtotal;
  String? transactionStatus;
  String? paymentType;
  String? orderedAt;
  String? orderStatus;
  String? userNotify;
  String? pharmacyNotify;
  String? prescriptionImage;

  OrderDetails(
      {this.id,
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
      this.pharmacyId,
      this.orderId,
      this.userOrderId,
      this.productName,
      this.productId,
      this.quantity,
      this.subtotal,
      this.transactionStatus,
      this.paymentType,
      this.orderedAt,
      this.orderStatus,
      this.userNotify,
      this.pharmacyNotify,
      this.prescriptionImage});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    userId = json['user_id'] ?? '';
    name = json['name'] ?? '';
    slug = json['slug'] ?? '';
    category = json['category'] ?? '';
    subcategory = json['subcategory'] ?? '';
    unitValue = json['unit_value'] ?? '';
    unit = json['unit'] ?? '';
    price = json['price'] ?? '';
    salePrice = json['sale_price'] ?? '';
    discount = json['discount'] ?? '';
    description = json['description'] ?? '';
    shortDescription = json['short_description'] ?? '';
    manufacturedBy = json['manufactured_by'] ?? '';
    medicineType = json['medicine_type'] ?? '';
    uploadImageUrl = json['upload_image_url'] ?? '';
    uploadPreviewImageUrl = json['upload_preview_image_url'] ?? '';
    createdDate = json['created_date'] ?? '';
    stockStatus = json['stock_status'] ?? '';
    composition = json['composition'] ?? '';
    status = json['status'] ?? '';
    featured = json['featured'] ?? '';
    expiryDate = json['expiry_date'] ?? '';
    oldPId = json['old_p_id'] ?? '';
    pharmacyId = json['pharmacy_id'] ?? '';
    orderId = json['order_id'] ?? '';
    userOrderId = json['user_order_id'] ?? '';
    productName = json['product_name'] ?? '';
    productId = json['product_id'] ?? '';
    quantity = json['quantity'] ?? '';
    subtotal = json['subtotal'] ?? '';
    transactionStatus = json['transaction_status'] ?? '';
    paymentType = json['payment_type'] ?? '';
    orderedAt = json['ordered_at'] ?? '';
    orderStatus = json['order_status'] ?? '';
    userNotify = json['user_notify'] ?? '';
    pharmacyNotify = json['pharmacy_notify'] ?? '';
    prescriptionImage = json['prescription_image'] ?? '';
  }
}
