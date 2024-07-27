import 'package:teleprac/core/const/links.dart';
import 'package:teleprac/model/labs/tests/advanced_test_model.dart';

class TestModel {
  String? labName;
  String? id;
  String? labId;
  String? profileimage;
  String? labTestName;
  String? amount;
  String? mrp;
  String? currencyCode;
  String? currencySymbol;
  String? discount;
  String? status;
  String? duration;
  String? description;
  String? createdDate;
  String? category;

  TestModel({
    this.labName,
    this.id,
    this.labId,
    this.profileimage,
    this.labTestName,
    this.amount,
    this.mrp,
    this.currencyCode,
    this.currencySymbol,
    this.discount,
    this.status,
    this.duration,
    this.description,
    this.createdDate,
    this.category,
  });

  TestModel.fromJson(Map<String, dynamic> json) {
    labName = json['lab_name'];
    id = json['id'];
    labId = json['lab_id'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    labTestName = json['lab_test_name'];
    amount = json['amount'];
    mrp = json['mrp'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    discount = json['discount'];
    status = json['status'];
    duration = json['duration'];
    description = json['description'];
    createdDate = json['created_date'];
    category = json['category'];
  }

  TestModel.fromAdvancedTestModel(AdvancedTestModel advancedTestModel) {
    labName = advancedTestModel.labDetails?.fullName;
    id = advancedTestModel.testDetails!.labTestId;
    labId = advancedTestModel.testDetails!.labId;
    profileimage = advancedTestModel.labDetails!.profileimage;
    labTestName = advancedTestModel.testDetails!.labTestName;
    amount = advancedTestModel.testDetails!.amount;
    mrp = advancedTestModel.testDetails!.mrp;
    discount = advancedTestModel.testDetails!.discount;
    description = advancedTestModel.testDetails!.description;
  }
}
