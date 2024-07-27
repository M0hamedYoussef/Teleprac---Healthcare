import 'package:teleprac/core/const/links.dart';

class OrderModel {
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
  String? prescriptionImage;
  String? pharmacyFirstName;
  String? pharmacyLastName;
  String? pharmacyName;
  String? qty;

  OrderModel(
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
      this.prescriptionImage,
      this.pharmacyFirstName,
      this.pharmacyLastName,
      this.pharmacyName,
      this.qty});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderUserDetailsId = json['order_user_details_id'];
    fullName = json['full_name'];
    userId = json['user_id'];
    pharmacyId = json['pharmacy_id'];
    address1 = json['address1'];
    address2 = json['address2'];
    state = json['state'];
    email = json['email'];
    postalCode = json['postal_code'];
    status = json['status'];
    city = json['city'];
    country = json['country'];
    paymentMethod = json['payment_method'];
    phoneno = json['phoneno'].toString().replaceAll('+91', '');
    zipcode = json['zipcode'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    currency = json['currency'];
    shipping = json['shipping'].toString();
    prescriptionImage = json['prescription_image'] == null
        ? null
        : json['prescription_image']!.toString().isEmpty
            ? null
            : '${AppLinks.baseUrl}/${json['prescription_image']}';
    pharmacyFirstName = json['pharmacy_first_name'];
    pharmacyLastName = json['pharmacy_last_name'];
    pharmacyName = json['pharmacy_name'];
    qty = json['qty'];
  }
}
