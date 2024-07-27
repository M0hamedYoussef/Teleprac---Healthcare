import 'package:teleprac/core/const/links.dart';

class LabAppointmentModel {
  String? id;
  String? profileimage;
  String? firstName;
  String? lastName;
  String? fullName;
  String? patientId;
  String? labId;
  String? date;
  String? status;
  String? amount;
  String? currencyCode;
  String? currencySymbol;
  String? testName;
  List<Documents>? documents;

  LabAppointmentModel({
    this.id,
    this.profileimage,
    this.firstName,
    this.lastName,
    this.fullName,
    this.patientId,
    this.labId,
    this.date,
    this.status,
    this.amount,
    this.currencyCode,
    this.currencySymbol,
    this.testName,
    this.documents,
  });

  LabAppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileimage = json['profileimage'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = '$firstName $lastName';
    patientId = json['patient_id'];
    labId = json['lab_id'];
    date = json['date'];
    status = json['status'];
    amount = json['amount'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    testName = json['test_name'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }
}

class Documents {
  String? type;
  String? file;

  Documents({this.type, this.file});

  Documents.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    file = '${AppLinks.baseUrl}/${json['file']}';
  }
}
