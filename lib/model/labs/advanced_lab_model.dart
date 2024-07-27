import 'package:html/parser.dart';
import 'package:teleprac/core/const/links.dart';

class AdvancedLabModel {
  String? labId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? username;
  String? mobileno;
  String? profileimage;
  String? id;
  dynamic registerNo;
  String? userId;
  String? gender;
  String? dob;
  String? bloodGroup;
  String? biography;
  String? clinicName;
  String? clinicAddress;
  String? address1;
  String? address2;
  String? country;
  String? state;
  String? city;
  String? postalCode;
  String? priceType;
  String? amount;
  String? currencyCode;
  String? services;
  dynamic keywordsD;
  String? specialization;
  String? status;
  String? updateAt;
  dynamic cONSULTATIONMODE;
  String? clinicAddress2;
  String? clinicCity;
  String? clinicState;
  String? clinicCountry;
  String? clinicPostal;
  String? clinicname;
  dynamic subscriptionEnd;
  String? subscriptionType;
  String? counselingType;
  String? sendmailStatus;
  String? videoStatus;
  String? chatStatus;
  String? website;
  String? insuranceAccepted;
  String? offer;
  dynamic practiceyears;
  dynamic height;
  dynamic weight;
  dynamic lmp;
  dynamic medicalHistory;
  String? countryname;
  String? statename;
  String? cityname;
  String? ratingCount;
  String? ratingValue;
  String? fullAddress;

  AdvancedLabModel({
    this.labId,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.username,
    this.mobileno,
    this.profileimage,
    this.id,
    this.registerNo,
    this.userId,
    this.gender,
    this.dob,
    this.bloodGroup,
    this.biography,
    this.clinicName,
    this.clinicAddress,
    this.address1,
    this.address2,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.priceType,
    this.amount,
    this.currencyCode,
    this.services,
    this.keywordsD,
    this.specialization,
    this.status,
    this.updateAt,
    this.cONSULTATIONMODE,
    this.clinicAddress2,
    this.clinicCity,
    this.clinicState,
    this.clinicCountry,
    this.clinicPostal,
    this.clinicname,
    this.subscriptionEnd,
    this.subscriptionType,
    this.counselingType,
    this.sendmailStatus,
    this.videoStatus,
    this.chatStatus,
    this.website,
    this.insuranceAccepted,
    this.offer,
    this.practiceyears,
    this.height,
    this.weight,
    this.lmp,
    this.medicalHistory,
    this.countryname,
    this.statename,
    this.cityname,
    this.ratingCount,
    this.fullAddress,
    this.ratingValue,
  });

  AdvancedLabModel.fromJson(Map<String, dynamic> json) {
    labId = json['lab_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = '$firstName $lastName';
    email = json['email'];
    username = json['username'];
    mobileno = json['mobileno'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    id = json['id'];
    registerNo = json['register_no'];
    userId = json['user_id'];
    gender = json['gender'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    biography = parse(json['biography']).body!.text;
    clinicName = json['clinic_name'];
    clinicAddress = json['clinic_address'];
    address1 = json['address1'];
    address2 = json['address2'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'];
    priceType = json['price_type'];
    amount = json['amount'];
    currencyCode = json['currency_code'];
    services = json['services'];
    keywordsD = json['keywords_d'];
    specialization = json['specialization'];
    status = json['status'];
    updateAt = json['update_at'];
    cONSULTATIONMODE = json['CONSULTATION_MODE'];
    clinicAddress2 = json['clinic_address2'];
    clinicCity = json['clinic_city'];
    clinicState = json['clinic_state'];
    clinicCountry = json['clinic_country'];
    clinicPostal = json['clinic_postal'];
    clinicname = json['clinicname'];
    subscriptionEnd = json['subscription_end'];
    subscriptionType = json['subscription_type'];
    counselingType = json['counseling_type'];
    sendmailStatus = json['sendmail_status'];
    videoStatus = json['video_status'];
    chatStatus = json['chat_status'];
    website = json['website'];
    insuranceAccepted = json['insurance_accepted'];
    offer = json['offer'];
    practiceyears = json['practiceyears'];
    height = json['height'];
    weight = json['weight'];
    lmp = json['lmp'];
    medicalHistory = json['medical_history'];
    countryname = json['countryname'];
    statename = json['statename'];
    cityname = json['cityname'];
    fullAddress = '$cityname, $statename ,$countryname';
    ratingCount = json['rating_count'];
    ratingValue = json['rating_value'];
  }
}
