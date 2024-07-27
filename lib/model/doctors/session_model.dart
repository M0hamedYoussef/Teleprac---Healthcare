class SessionModel {
  String? session;
  String? sessionStartTime;
  String? sessionEndTime;
  String? sessionSlot;
  List<TokenDetailsModel>? tokenDetails;

  SessionModel({
    this.session,
    this.sessionStartTime,
    this.sessionEndTime,
    this.sessionSlot,
    this.tokenDetails,
  });

  SessionModel.fromJson(Map<String, dynamic> json) {
    session = json['session'];
    sessionStartTime = json['session_start_time'];
    sessionEndTime = json['session_end_time'];
    sessionSlot = json['session_slot'];
    if (json['token_details'] != null) {
      tokenDetails = <TokenDetailsModel>[];
      json['token_details'].forEach((v) {
        tokenDetails!.add(TokenDetailsModel.fromJson(v));
      });
    }
  }
}

class TokenDetailsModel {
  String? tokenScheduleDate;
  String? tokenTimeZone;
  String? tokenStartTime;
  String? tokenEndTime;
  String? tokenSession;
  String? tokenNo;
  String? isSelected;
  String? tokenType;

  TokenDetailsModel({
    this.tokenScheduleDate,
    this.tokenTimeZone,
    this.tokenStartTime,
    this.tokenEndTime,
    this.tokenSession,
    this.tokenNo,
    this.isSelected,
    this.tokenType,
  });

  TokenDetailsModel.fromJson(Map<String, dynamic> json) {
    tokenScheduleDate = json['token_schedule_date'];
    tokenTimeZone = json['token_time_zone'];
    tokenStartTime = json['token_start_time'];
    tokenEndTime = json['token_end_time'];
    tokenSession = json['token_session'];
    tokenNo = json['token_no'];
    isSelected = json['is_selected'];
    tokenType = json['token_type'];
  }
}
