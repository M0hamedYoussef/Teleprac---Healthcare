import 'package:teleprac/core/const/links.dart';

class LabModel {
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

  LabModel({
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
  });

  LabModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = '$firstName $lastName';
    specializationImg = '${AppLinks.baseUrl}/${json['specialization_img']}';
    speciality = json['speciality'];
    cityname = json['cityname'];
    countryname = json['countryname'];
    fullAddress = '$cityname, $countryname';
    services = json['services'];
    ratingValue = json['rating_value'];
    ratingCount = json['rating_count'];
  }
}
