class AccountDetailsModel {
  String? currencySymbol;
  double? balance;
  double? requested;
  double? earned;
  AccountDetails? accountDetails;

  AccountDetailsModel({
    this.currencySymbol,
    this.balance,
    this.requested,
    this.earned,
    this.accountDetails,
  });

  AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    currencySymbol = json['currency_symbol'];
    balance = double.parse((json['balance'] ?? '0').toString());
    requested = double.parse((json['requested'] ?? '0').toString());
    earned = double.parse((json['earned'] ?? '0').toString());
    accountDetails = json['account_details'] != null
        ? AccountDetails.fromJson(json['account_details'])
        : null;
  }
}

class AccountDetails {
  String? id;
  String? userId;
  String? bankName;
  String? branchName;
  String? accountNo;
  String? accountName;
  String? ifscCode;
  String? upiId;
  String? status;

  AccountDetails({
    this.id,
    this.userId,
    this.bankName,
    this.branchName,
    this.accountNo,
    this.accountName,
    this.ifscCode,
    this.upiId,
    this.status,
  });

  AccountDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    accountNo = json['account_no'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    upiId = json['upi_id'];
    status = json['status'];
  }
}
