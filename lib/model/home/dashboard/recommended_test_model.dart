import 'package:teleprac/core/const/links.dart';

class RecommendedTestModel {
  String? id;
  String? patientImage;
  String? doctorImage;
  String? patientName;
  String? doctorName;
  String? amount;
  String? labId;
  String? age;
  String? gender;
  String? address;
  String? delivery;
  String? chiefComplaints;
  String? paymentStatus;
  String? signatureImage;
  String? createdDate;
  List<LabtestDetails>? labtestDetails;
  String? pdfLink;

  RecommendedTestModel(
      {this.id,
      this.patientImage,
      this.doctorImage,
      this.patientName,
      this.doctorName,
      this.amount,
      this.labId,
      this.age,
      this.gender,
      this.address,
      this.delivery,
      this.chiefComplaints,
      this.paymentStatus,
      this.signatureImage,
      this.createdDate,
      this.labtestDetails,
      this.pdfLink});

  RecommendedTestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientImage = json['patient_image'];
    doctorImage = json['doctor_image'];
    patientName = json['patient_name'];
    doctorName = json['doctor_name'];
    amount = json['amount'];
    labId = json['lab_id'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    delivery = json['delivery'];
    chiefComplaints = json['chief_complaints'];
    paymentStatus = json['payment_status'];
    signatureImage = '${AppLinks.baseUrl}/${json['signature_image']}';
    createdDate = json['created_date'];
    if (json['labtest_details'] != null) {
      labtestDetails = <LabtestDetails>[];
      json['labtest_details'].forEach((v) {
        labtestDetails!.add(LabtestDetails.fromJson(v));
      });
    }
    pdfLink = json['pdf_link'];
  }
}

class LabtestDetails {
  String? tId;
  String? labcId;
  String? testId;
  String? testName;
  String? prepBeforeTest;
  String? time;
  String? createdAt;
  String? price;
  String? discount;
  String? finalPrice;

  LabtestDetails({
    this.tId,
    this.labcId,
    this.testId,
    this.testName,
    this.prepBeforeTest,
    this.time,
    this.createdAt,
    this.price,
    this.discount,
    this.finalPrice,
  });

  LabtestDetails.fromJson(Map<String, dynamic> json) {
    tId = json['t_id'];
    labcId = json['labc_id'];
    testId = json['test_id'];
    testName = json['test_name'];
    prepBeforeTest = json['prep_before_test'];
    time = json['time'];
    createdAt = json['created_at'];
    price = json['price'];
    discount = json['discount'];
    finalPrice = json['final'];
  }
}
