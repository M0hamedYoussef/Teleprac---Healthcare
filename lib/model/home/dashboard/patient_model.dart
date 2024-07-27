class PatientModel {
  String? id;
  String? patientId;
  String? username;
  String? profileimage;
  String? firstName;
  String? lastName;
  String? fullName;
  String? mobileno;
  String? dob;
  String? age;
  String? bloodGroup;
  String? gender;
  String? cityname;
  String? countryname;
  String? fullAddress;
  String? patientListCount;

  PatientModel({
    this.id,
    this.patientId,
    this.username,
    this.profileimage,
    this.firstName,
    this.lastName,
    this.fullName,
    this.mobileno,
    this.dob,
    this.age,
    this.bloodGroup,
    this.gender,
    this.cityname,
    this.countryname,
    this.fullAddress,
    this.patientListCount,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    username = json['username'];
    profileimage = json['profileimage'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = '$firstName $lastName';
    mobileno = json['mobileno'];
    dob = json['dob'];
    age = json['age'];
    bloodGroup = json['blood_group'];
    gender = json['gender'];
    cityname = json['cityname'];
    countryname = json['countryname'];
    fullAddress = cityname == null ? 'India' : '$cityname, India';
    patientListCount = json['patient_list_count'];
  }
}
