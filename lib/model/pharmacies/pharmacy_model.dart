class PharmacyModel {
  String? id;
  String? pharmacyName;
  String? profileimage;
  String? phonecode;
  String? mobileno;
  String? address1;
  String? address2;
  String? city;
  String? statename;
  String? country;
  String? pharmacyOpensAt;

  PharmacyModel({
    this.id,
    this.pharmacyName,
    this.profileimage,
    this.phonecode,
    this.mobileno,
    this.address1,
    this.address2,
    this.city,
    this.statename,
    this.country,
    this.pharmacyOpensAt,
  });

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyName = json['pharmacy_name'];
    profileimage = json['profileimage'];
    phonecode = json['phonecode'];
    mobileno = json['mobileno'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    statename = json['statename'];
    country = json['country'];
    pharmacyOpensAt = json['pharmacy_opens_at'];
  }
}
