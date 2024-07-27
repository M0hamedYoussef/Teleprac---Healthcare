import 'package:html/parser.dart';
import 'package:teleprac/core/const/links.dart';

class AdvancedDoctorModel {
  dynamic socialDetails;
  dynamic businessHours;
  DoctorDetails? doctorDetails;
  String? expYears;
  List<Education>? education;
  List? educationDegrees;
  List<Experience>? experience;
  List? awards;
  List<Memberships>? memberships;
  List<Registrations>? registrations;
  List? reviews;

  AdvancedDoctorModel({
    this.socialDetails,
    this.doctorDetails,
    this.education,
    this.experience,
    this.awards,
    this.memberships,
    this.registrations,
    this.businessHours,
    this.reviews,
    this.expYears,
  });

  AdvancedDoctorModel.fromJson(dynamic json) {
    socialDetails = json['social_details'];
    doctorDetails = json['doctor_details'] != null
        ? DoctorDetails.fromJson(json['doctor_details'])
        : null;
    if (json['education'] != null) {
      education = <Education>[];
      educationDegrees = [];

      json['education'].forEach((v) {
        Education educationElement = Education.fromJson(v);
        education!.add(educationElement);
        educationDegrees!.add(educationElement.degree);
      });
    }
    if (json['experience'] != null) {
      experience = <Experience>[];
      json['experience'].forEach((v) {
        experience!.add(Experience.fromJson(v));
      });
    }
    awards = json['awards'];
    if (json['memberships'] != null) {
      memberships = <Memberships>[];
      json['memberships'].forEach((v) {
        memberships!.add(Memberships.fromJson(v));
      });
    }
    if (json['registrations'] != null) {
      registrations = <Registrations>[];
      json['registrations'].forEach((v) {
        registrations!.add(Registrations.fromJson(v));
      });
    }
    businessHours = json['business_hours'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (education != null) {
      data['education'] = education!.map((v) => v.toJson()).toList();
    }
    if (experience != null) {
      data['experience'] = experience!.map((v) => v.toJson()).toList();
    }
    if (awards != null) {
      data['awards'] = awards!.toList();
    }
    if (memberships != null) {
      data['memberships'] = memberships!.map((v) => v.toJson()).toList();
    }
    if (registrations != null) {
      data['registrations'] = registrations!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class DoctorDetails {
  String? userid;
  String? currency;
  String? currencyCode;
  String? isFavourite;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? username;
  String? mobileno;
  String? profileimage;
  String? userId;
  String? gender;
  String? dob;
  String? bloodGroup;
  String? biography;
  String? clinicName;
  String? clinicAddress;
  String? address1;
  String? address2;
  String? postalCode;
  String? priceType;
  String? amount;
  String? services;
  String? countryname;
  String? statename;
  String? cityname;
  String? fullAddress;
  String? speciality;
  String? specializationImg;
  String? ratingCount;
  String? ratingValue;
  String? id;
  String? registerNo;
  String? country;
  String? state;
  String? city;
  String? keywordsD;
  String? specialization;
  String? status;
  String? updateAt;
  String? cONSULTATIONMODE;
  String? clinicAddress2;
  String? clinicCity;
  String? clinicState;
  String? clinicCountry;
  String? clinicPostal;
  String? clinicname;
  String? subscriptionEnd;
  String? subscriptionType;
  String? counselingType;
  String? sendmailStatus;
  String? videoStatus;
  String? chatStatus;
  String? website;
  String? insuranceAccepted;
  String? offer;
  String? practiceyears;
  String? height;
  String? weight;
  String? lmp;
  String? medicalHistory;

  DoctorDetails({
    this.userid,
    this.currency,
    this.currencyCode,
    this.isFavourite,
    this.fullAddress,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.username,
    this.mobileno,
    this.profileimage,
    this.userId,
    this.gender,
    this.dob,
    this.bloodGroup,
    this.biography,
    this.clinicName,
    this.clinicAddress,
    this.address1,
    this.address2,
    this.postalCode,
    this.priceType,
    this.amount,
    this.services,
    this.countryname,
    this.statename,
    this.cityname,
    this.speciality,
    this.specializationImg,
    this.ratingCount,
    this.ratingValue,
    this.id,
    this.registerNo,
    this.country,
    this.state,
    this.city,
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
  });

  DoctorDetails.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    isFavourite = json['is_favourite'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = 'Dr. $firstName $lastName';
    email = json['email'];
    username = json['username'];
    mobileno = json['mobileno'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    userId = json['user_id'];
    gender = json['gender'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    biography = parse(json['biography']).body!.text;
    clinicName = json['clinic_name'];
    clinicAddress = json['clinic_address'];
    address1 = json['address1'];
    address2 = json['address2'];
    postalCode = json['postal_code'];
    priceType = json['price_type'];
    amount = json['amount'];
    services = json['services'];
    countryname = json['countryname'];
    statename = json['statename'];
    cityname = json['cityname'];
    fullAddress = '$cityname, India';
    speciality = json['speciality'];
    specializationImg = '${AppLinks.baseUrl}/${json['specialization_img']}';
    ratingCount = json['rating_count'];
    ratingValue = json['rating_value'];
    id = json['id'];
    registerNo = json['register_no'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
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
  }
}

class Education {
  String? id;
  String? userId;
  String? degree;
  String? institute;
  String? yearOfCompletion;

  Education({
    this.id,
    this.userId,
    this.degree,
    this.institute,
    this.yearOfCompletion,
  });

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    degree = json['degree'];
    institute = json['institute'];
    yearOfCompletion = json['year_of_completion'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['degree'] = degree;
    data['institute'] = institute;
    data['year_of_completion'] = yearOfCompletion;
    return data;
  }
}

class Experience {
  String? id;
  String? userId;
  String? hospitalName;
  String? from;
  String? to;
  String? designation;

  Experience({
    this.id,
    this.userId,
    this.hospitalName,
    this.from,
    this.to,
    this.designation,
  });

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    hospitalName = json['hospital_name'];
    from = json['from'];
    to = json['to'];
    designation = json['designation'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['hospital_name'] = hospitalName;
    data['from'] = from;
    data['to'] = to;
    data['designation'] = to;
    return data;
  }
}

class Memberships {
  String? id;
  String? userId;
  String? memberships;

  Memberships({this.id, this.userId, this.memberships});

  Memberships.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    memberships = json['memberships'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['memberships'] = memberships;
    return data;
  }
}

class Registrations {
  String? id;
  String? userId;
  String? registrations;
  String? registrationsYear;
  String? registrationsTs;

  Registrations({
    this.id,
    this.userId,
    this.registrations,
    this.registrationsYear,
    this.registrationsTs,
  });

  Registrations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    registrations = json['registrations'];
    registrationsYear = json['registrations_year'];
    registrationsTs = json['registrations_ts'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['registrations'] = registrations;
    data['registrations_year'] = registrationsYear;
    data['registrations_ts'] = registrationsTs;
    return data;
  }
}
