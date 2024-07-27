import 'package:teleprac/core/const/links.dart';

class AccountModel {
  String? id;
  String? date;
  String? patientProfileimage;
  String? patientId;
  String? patientName;
  String? amount;
  String? status;
  String? requestStatus;
  String? statustxt;

  AccountModel({
    this.id,
    this.date,
    this.patientProfileimage,
    this.patientId,
    this.patientName,
    this.amount,
    this.status,
    this.requestStatus,
    this.statustxt,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    patientProfileimage = '${AppLinks.baseUrl}/${json['patient_profileimage']}';
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    amount = json['amount'];
    status = json['status'];
    requestStatus = json['request_status'];
    statustxt = json['statustxt'];
  }
}
