class InvoiceModel {
  String? id;
  String? invoiceNo;
  String? profileimage;
  String? amount;
  String? date;
  String? name;
  String? profile;
  String? role;
  String? patientRole;

  InvoiceModel({
    this.id,
    this.invoiceNo,
    this.profileimage,
    this.amount,
    this.date,
    this.name,
    this.profile,
    this.role,
    this.patientRole,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    profileimage = json['profileimage'];
    amount = json['amount'];
    date = json['date'];
    name = json['name'];
    profile = json['profile'];
    role = json['role'];
    patientRole = json['patient_role'];
  }
}
