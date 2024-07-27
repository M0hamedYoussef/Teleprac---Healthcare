class PatientProfileModel {
  Map? data;
  String? userid;
  String? insuranceName;
  String? policyNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? mobileno;
  String? profileimage;
  String? userId;
  String? gender;
  String? dob;
  String? bloodGroup;
  String? address1;
  String? address2;
  String? postalCode;
  String? country;
  String? state;
  String? city;
  String? countryname;
  String? statename;
  String? cityname;
  String? pharmacyName;

  PatientProfileModel({
    this.data,
    this.userid,
    this.insuranceName,
    this.policyNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.mobileno,
    this.profileimage,
    this.userId,
    this.gender,
    this.dob,
    this.bloodGroup,
    this.address1,
    this.address2,
    this.postalCode,
    this.country,
    this.state,
    this.city,
    this.countryname,
    this.statename,
    this.cityname,
    this.pharmacyName,
  });

  PatientProfileModel.fromJson(Map<String, dynamic> json) {
    data = json;
    userid = json['userid'] ?? '';
    insuranceName = json['insurance_name'] ?? '';
    policyNumber = json['policy_number'] ?? '';
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    email = json['email'] ?? '';
    username = json['username'] ?? '';
    mobileno = json['mobileno'] ?? '';
    profileimage = json['profileimage'] ?? '';
    userId = json['user_id'] ?? '';
    gender = json['gender'] ?? '';
    dob = json['dob'] ?? '';
    bloodGroup = json['blood_group'] ?? '';
    address1 = json['address1'] ?? '';
    address2 = json['address2'] ?? '';
    postalCode = json['postal_code'] ?? '';
    country = json['country'] ?? '';
    state = json['state'] ?? '';
    city = json['city'] ?? '';
    countryname = json['countryname'] ?? '';
    statename = json['statename'] ?? '';
    cityname = json['cityname'] ?? '';
    pharmacyName = json['pharmacy_name'] ?? '';
  }
}
