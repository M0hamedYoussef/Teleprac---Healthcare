
class AdvancedInvoiceModel {
  List<InvoiceList>? invoiceList;
  String? currency;
  String? userTranscationCharge;
  String? userTaxAmount;
  String? userTotalAmount;
  String? createdDate;
  List<AppoinmentDetails>? appoinmentDetails;

  AdvancedInvoiceModel({
    this.invoiceList,
    this.currency,
    this.userTranscationCharge,
    this.userTaxAmount,
    this.userTotalAmount,
    this.createdDate,
    this.appoinmentDetails,
  });

  AdvancedInvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['invoice_list'] != null) {
      invoiceList = <InvoiceList>[];
      json['invoice_list'].forEach((v) {
        invoiceList!.add(InvoiceList.fromJson(v));
      });
    }
    currency = json['currency'] ?? '';
    userTranscationCharge = json['user_transcation_charge'].toString();
    userTaxAmount = json['user_tax_amount'].toString();
    userTotalAmount = json['user_total_amount'].toString();

    if (json['appoinment_details'] != null) {
      appoinmentDetails = <AppoinmentDetails>[];
      json['appoinment_details'].forEach((v) {
        appoinmentDetails!.add(AppoinmentDetails.fromJson(v));
      });
    }
  }
}

class InvoiceList {
  String? id;
  String? userId;
  String? doctorId;
  String? labId;
  String? patientId;
  String? invoiceNo;
  String? perHourCharge;
  String? totalAmount;
  String? currencyCode;
  String? txnId;
  String? orderId;
  String? transactionStatus;
  String? paymentType;
  String? tax;
  String? taxAmount;
  String? transcationCharge;
  String? paymentStatus;
  String? paymentDate;
  String? commission;
  String? status;
  String? requestStatus;
  String? doctorName;
  String? doctorUsername;
  String? doctorProfileimage;
  String? patientName;
  String? patientProfileimage;
  String? pharCountryname;
  String? pharStatename;
  String? pharCityname;
  String? pharFullAddress;
  String? userCountryname;
  String? userStatename;
  String? userCityname;
  String? userFullAddress;
  String? address1;
  String? address2;
  String? userAddress1;
  String? userAddress2;

  String? role;

  InvoiceList({
    this.id,
    this.userId,
    this.doctorId,
    this.labId,
    this.patientId,
    this.invoiceNo,
    this.perHourCharge,
    this.totalAmount,
    this.currencyCode,
    this.txnId,
    this.orderId,
    this.transactionStatus,
    this.paymentType,
    this.tax,
    this.taxAmount,
    this.transcationCharge,
    this.paymentStatus,
    this.paymentDate,
    this.commission,
    this.status,
    this.requestStatus,
    this.doctorName,
    this.doctorUsername,
    this.doctorProfileimage,
    this.patientName,
    this.patientProfileimage,
    this.pharCountryname,
    this.pharStatename,
    this.pharCityname,
    this.userCountryname,
    this.userStatename,
    this.userCityname,
    this.address1,
    this.address2,
    this.userAddress1,
    this.userAddress2,
    this.role,
    this.pharFullAddress,
    this.userFullAddress,
  });

  InvoiceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    labId = json['lab_id'];
    patientId = json['patient_id'];
    invoiceNo = json['invoice_no'];
    perHourCharge = json['per_hour_charge'];
    totalAmount = json['total_amount'];
    currencyCode = json['currency_code'];
    txnId = json['txn_id'];
    orderId = json['order_id'];
    transactionStatus = json['transaction_status'];
    paymentType = json['payment_type'];
    tax = json['tax'];
    taxAmount = json['tax_amount'];
    transcationCharge = json['transcation_charge'];
    paymentStatus = json['payment_status'];
    paymentDate = json['payment_date'];
    commission = json['commission'];
    status = json['status'];
    requestStatus = json['request_status'];
    doctorName = json['doctor_name'];
    doctorUsername = json['doctor_username'];
    doctorProfileimage = json['doctor_profileimage'];
    patientName = json['patient_name'];
    patientProfileimage = json['patient_profileimage'];
    pharCountryname = json['phar_countryname'];
    pharStatename = json['phar_statename'];
    pharCityname = json['phar_cityname'];
    userCountryname = json['user_countryname'];
    userStatename = json['user_statename'];
    userCityname = json['user_cityname'];
    address1 = json['address1'];
    address2 = json['address2'];
    userAddress1 = json['user_address1'];
    userAddress2 = json['user_address2'];
    role = json['role'];
    pharFullAddress = '$pharCityname, $pharStatename, $pharCountryname';
    userFullAddress = '$userCityname, $userStatename, $userCountryname';
  }
}

class AppoinmentDetails {
  int? sno;
  String? type;
  String? typeText;
  String? amount;

  AppoinmentDetails({this.sno, this.type, this.typeText, this.amount});

  AppoinmentDetails.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    type = json['type'];
    typeText = json['type_text'];
    amount = json['amount'];
  }
}
