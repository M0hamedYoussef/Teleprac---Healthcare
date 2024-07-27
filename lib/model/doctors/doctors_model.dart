import 'package:teleprac/core/const/links.dart';

class DoctorModel {
  Map? data;
  String? id;
  String? username;
  String? profileimage;
  String? firstName;
  String? lastName;
  String? fullName;
  String? specializationImg;
  String? speciality;
  String? cityname;
  String? countryname;
  String? fullAddress;
  String? services;
  String? ratingValue;
  String? ratingCount;
  String? isFavourite;
  String? currency;
  String? priceType;
  String? slotType;
  String? amount;
  String? gender;
  String? experience;
  String? featured;

  DoctorModel({
    this.data,
    this.id,
    this.username,
    this.profileimage,
    this.firstName,
    this.lastName,
    this.fullName,
    this.specializationImg,
    this.speciality,
    this.cityname,
    this.countryname,
    this.fullAddress,
    this.services,
    this.ratingValue,
    this.ratingCount,
    this.isFavourite,
    this.currency,
    this.priceType,
    this.slotType,
    this.amount,
    this.gender,
    this.experience,
    this.featured,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    data = json;
    id = json['id'];
    username = json['username'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = 'Dr. ${firstName!.replaceAll('Dr.', '')} $lastName';
    specializationImg = '${AppLinks.baseUrl}/${json['specialization_img']}';
    speciality = json['speciality'];
    cityname = json['cityname'];
    countryname = json['countryname'];
    fullAddress = '$cityname, India';
    services = json['services'];
    ratingValue = json['rating_value'] ?? '0';
    ratingCount = json['rating_count'];
    isFavourite = json['is_favourite'];
    currency = json['currency'];
    priceType = json['price_type'];
    slotType = json['slot_type'];
    amount = json['amount'];
    gender = json['gender'];
    experience = json['experience'];
    featured = json['featured'];
  }
}
