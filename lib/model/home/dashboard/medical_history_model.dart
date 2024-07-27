import 'package:teleprac/core/const/links.dart';

class MedicalHistoryItemModel {
  String? id;
  String? patientImage;
  String? doctorImage;
  String? patientName;
  String? doctorName;
  String? specialization;
  String? filename;
  String? description;
  String? recordType;
  String? createdDate;

  MedicalHistoryItemModel({
    this.id,
    this.patientImage,
    this.doctorImage,
    this.patientName,
    this.doctorName,
    this.specialization,
    this.filename,
    this.description,
    this.recordType,
    this.createdDate,
  });

  MedicalHistoryItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientImage = '${AppLinks.baseUrl}/${json['patient_image']}';
    doctorImage = '${AppLinks.baseUrl}/${json['doctor_image']}';
    patientName = json['patient_name'];
    doctorName = json['doctor_name'];
    specialization = json['specialization'];
    filename = json['filename'].toString() != 'null' &&
            json['filename'].toString().isNotEmpty
        ? '${AppLinks.baseUrl}/${json['filename']}'
        : '';
    description = json['description'];
    recordType = json['record_type'];
    createdDate = json['created_date'];
  }
}
