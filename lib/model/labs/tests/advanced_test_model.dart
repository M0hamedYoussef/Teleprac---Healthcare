import 'package:teleprac/core/const/links.dart';

class AdvancedTestModel {
  TestDetails? testDetails;
  LabDetails? labDetails;

  AdvancedTestModel({this.testDetails, this.labDetails});

  AdvancedTestModel.fromJson(Map<String, dynamic> json) {
    testDetails = json['test_details'] != null
        ? TestDetails.fromJson(json['test_details'])
        : null;
    labDetails = json['lab_details'] != null
        ? LabDetails.fromJson(json['lab_details'])
        : null;
  }
}

class TestDetails {
  String? labTestName;
  String? labTestId;
  String? labId;
  String? amount;
  String? mrp;
  String? discount;
  String? currencyCode;
  String? duration;
  String? description;
  String? parameter;
  String? category;
  String? preTestInfo;
  String? createdDate;
  String? isMaster;
  String? status;
  String? featured;

  TestDetails({
    this.labTestName,
    this.labTestId,
    this.labId,
    this.amount,
    this.mrp,
    this.discount,
    this.currencyCode,
    this.duration,
    this.description,
    this.parameter,
    this.category,
    this.preTestInfo,
    this.createdDate,
    this.isMaster,
    this.status,
    this.featured,
    required AdvancedTestModel advancedTestModel,
  });

  TestDetails.fromJson(Map<String, dynamic> json) {
    labTestId = json['test_id'];
    labTestName = json['lab_test_name'];
    labId = json['lab_id'];
    amount = json['amount'];
    mrp = json['mrp'];
    discount = json['discount'];
    currencyCode = json['currency_code'];
    duration = json['duration'];
    parameter = json['parameter'];
    description = json['description'];
    // description = parse(json['description'])
    //     .body
    //     ?.text
    //     .replaceAll('\n', '')
    //     .replaceAll(':', ':\n\n•')
    //     .replaceAll('.', '.\n\n');
    category = json['category'];
    preTestInfo = json['pre_test_info'];
    createdDate = json['created_date'];
    isMaster = json['is_master'];
    status = json['status'];
    featured = json['featured'];
  }
}

class LabDetails {
  String? userid;
  String? role;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? username;
  String? mobileno;
  String? profileimage;
  String? isVerified;
  String? isUpdated;
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
  dynamic speciality;
  dynamic specializationImg;
  String? hospitalId;

  LabDetails({
    this.userid,
    this.role,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.username,
    this.mobileno,
    this.profileimage,
    this.isVerified,
    this.isUpdated,
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
    this.speciality,
    this.specializationImg,
    this.hospitalId,
  });

  LabDetails.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json.containsKey('fullname')
        ? json['fullname']
        : '$firstName $lastName';
    email = json['email'];
    username = json['username'];
    mobileno = json['mobileno'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    isVerified = json['is_verified'];
    isUpdated = json['is_updated'];
    id = json['id'];
    registerNo = json['register_no'];
    userId = json['user_id'];
    gender = json['gender'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    biography = json['biography'];
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
    speciality = json['speciality'];
    specializationImg = json['specialization_img'];
    hospitalId = json['hospital_id'];
  }
}
