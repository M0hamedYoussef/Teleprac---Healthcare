import 'package:teleprac/core/const/links.dart';

class PrescriptionModel {
  String? id;
  String? patientImage;
  String? doctorImage;
  String? patientName;
  String? doctorName;
  String? specialization;
  String? signatureImage;
  String? createdDate;
  String? pdfLink;
  List<PrescriptionDetails>? prescriptionDetails;

  PrescriptionModel({
    this.id,
    this.patientImage,
    this.doctorImage,
    this.patientName,
    this.doctorName,
    this.specialization,
    this.signatureImage,
    this.createdDate,
    this.prescriptionDetails,
    this.pdfLink,
  });

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientImage = json['patient_image'];
    doctorImage = '${AppLinks.baseUrl}/${json['doctor_image']}';
    patientName = json['patient_name'];
    doctorName = json['doctor_name'];
    specialization = json['specialization'];
    signatureImage = '${AppLinks.baseUrl}/${json['signature_image']}';
    createdDate = json['created_date'];
    if (json['prescription_details'] != null) {
      prescriptionDetails = <PrescriptionDetails>[];
      json['prescription_details'].forEach((v) {
        prescriptionDetails!.add(PrescriptionDetails.fromJson(v));
      });
    }
    pdfLink = json['pdf_link'];
  }
}

class PrescriptionDetails {
  String? id;
  String? prescriptionId;
  String? drugName;
  String? qty;
  String? type;
  String? days;
  String? price;
  String? time;
  String? createdAt;
  String? discount;
  String? prescriptionFinal;

  PrescriptionDetails({
    this.id,
    this.prescriptionId,
    this.drugName,
    this.qty,
    this.type,
    this.days,
    this.price,
    this.time,
    this.createdAt,
    this.discount,
    this.prescriptionFinal,
  });

  PrescriptionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prescriptionId = json['prescription_id'];
    drugName = json['drug_name'];
    qty = json['qty'];
    type = json['type'];
    days = json['days'];
    price = json['price'];
    time = json['time'];
    createdAt = json['created_at'];
    discount = json['discount'];
    prescriptionFinal = json['final'];
  }
}
