import 'package:teleprac/core/const/links.dart';

class AppointmentModel {
  String? id;
  String? profileimage;
  String? firstName;
  String? lastName;
  String? fullName;
  String? patientId;
  String? patientUserId;
  String? doctorUserId;
  String? date;
  String? startTime;
  String? endTime;
  String? appoinmentStartTime;
  String? appoinmentEndTime;
  String? createdDate;
  String? type;
  String? paymentMethod;
  String? amount;
  String? approved;
  String? userRole;
  String? loginUserRole;

  AppointmentModel({
    this.id,
    this.profileimage,
    this.firstName,
    this.lastName,
    this.fullName,
    this.patientId,
    this.patientUserId,
    this.doctorUserId,
    this.date,
    this.startTime,
    this.endTime,
    this.appoinmentStartTime,
    this.appoinmentEndTime,
    this.createdDate,
    this.type,
    this.paymentMethod,
    this.amount,
    this.approved,
    this.userRole,
    this.loginUserRole,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = '$firstName $lastName';
    patientId = json['patient_id'];
    patientUserId = json['patient_user_id'];
    doctorUserId = json['doctor_user_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    appoinmentStartTime = json['appoinment_start_time'];
    appoinmentEndTime = json['appoinment_end_time'];
    createdDate = json['created_date'];
    type = json['type'];
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    approved = json['approved'];
    userRole = json['user_role'];
    loginUserRole = json['login_user_role'];
  }
}
