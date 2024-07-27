import 'package:teleprac/core/const/links.dart';

class AdvancedPrescriptionModel {
  String? registrationNumber;
  String? degree;
  String? createdDate;
  PrescriptionView? prescriptionView;
  List<ItemDetails>? itemDetails;

  AdvancedPrescriptionModel({
    this.registrationNumber,
    this.degree,
    this.prescriptionView,
    this.itemDetails,
  });

  AdvancedPrescriptionModel.fromJson(Map<String, dynamic> json) {
    registrationNumber =
        json['registrationNumber'].toString().replaceAll(',', '');
    degree = json['degree'];
    prescriptionView = json['prescription_view'] != null
        ? PrescriptionView.fromJson(json['prescription_view'])
        : null;

    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(ItemDetails.fromJson(v));
      });
    }
  }
}

class PrescriptionView {
  String? id;
  String? doctorId;
  String? patientId;
  String? familyId;
  String? signatureId;
  String? age;
  String? gender;
  String? address;
  String? height;
  String? weight;
  String? lmp;
  String? isOrder;
  String? pharmacyId;
  String? paymentStatus;
  String? createdAt;
  String? status;
  String? amount;
  String? paymentId;
  String? delivery;
  String? chiefComplaints;
  String? signatureImage;
  String? doctorName;
  String? doctorAddress;
  String? patientAddress;
  String? patientName;

  PrescriptionView({
    this.id,
    this.doctorId,
    this.patientId,
    this.familyId,
    this.signatureId,
    this.age,
    this.gender,
    this.address,
    this.height,
    this.weight,
    this.lmp,
    this.isOrder,
    this.pharmacyId,
    this.paymentStatus,
    this.createdAt,
    this.status,
    this.amount,
    this.paymentId,
    this.delivery,
    this.chiefComplaints,
    this.signatureImage,
    this.doctorName,
    this.doctorAddress,
    this.patientAddress,
    this.patientName,
  });

  PrescriptionView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    familyId = json['family_id'];
    signatureId = json['signature_id'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    height = json['height'];
    weight = json['weight'];
    lmp = json['lmp'];
    isOrder = json['is_order'];
    pharmacyId = json['pharmacy_id'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    status = json['status'];
    amount = json['amount'];
    paymentId = json['payment_id'];
    delivery = json['delivery'];
    chiefComplaints = json['chief_complaints'];
    signatureImage = '${AppLinks.baseUrl}/${json['signature_image']}';
    doctorName = json['doctor_name'];
    doctorAddress = json['doctor_address'];
    patientAddress = json['patient_address'];
    patientName = json['patient_name'];
  }
}

class ItemDetails {
  String? id;
  String? prescriptionId;
  String? drugName;
  String? actualPrice;
  String? qty;
  String? type;
  String? days;
  String? price;
  String? time;
  String? createdAt;
  String? discount;
  String? total;

  ItemDetails({
    this.id,
    this.prescriptionId,
    this.drugName,
    this.actualPrice,
    this.qty,
    this.type,
    this.days,
    this.price,
    this.time,
    this.createdAt,
    this.discount,
    this.total,
  });

  ItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prescriptionId = json['prescription_id'];
    drugName = json['drug_name'];
    actualPrice = json['actual_price'];
    qty = json['qty'];
    type = json['type'];
    days = json['days'];
    price = json['price'];
    time = json['time'];
    createdAt = json['created_at'];
    discount = json['discount'];
    total = json['final'];
  }
}
