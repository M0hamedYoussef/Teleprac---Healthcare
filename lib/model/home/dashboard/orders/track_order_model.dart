class TrackOrderModel {
  String? orderStatus;
  String? paymentType;
  String? pharmacyId;
  String? pharmacyName;
  String? firstName;
  String? lastName;

  TrackOrderModel({
    this.orderStatus,
    this.paymentType,
    this.pharmacyId,
    this.pharmacyName,
    this.firstName,
    this.lastName,
  });

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'] ?? '';
    paymentType = json['payment_type'] ?? '';
    pharmacyId = json['pharmacy_id'] ?? '';
    pharmacyName = json['pharmacy_name'] ?? '';
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
  }
}
