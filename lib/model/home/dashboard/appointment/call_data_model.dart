class CallDataModel {
  String? fromUserId;
  String? fromName;
  String? to;
  AdditionalKeyData? additionalKeyData;
  String? inviteId;
  String? type;
  String? sessionId;
  String? token;
  String? tokboxApiKey;
  String? tokboxApiSecret;

  CallDataModel({
    this.fromUserId,
    this.fromName,
    this.to,
    this.additionalKeyData,
    this.inviteId,
    this.type,
    this.sessionId,
    this.token,
    this.tokboxApiKey,
    this.tokboxApiSecret,
  });

  CallDataModel.fromJson(Map<String, dynamic> json) {
    fromUserId = json['from_user_id'];
    fromName = json['from_name'];
    to = json['to'];
    additionalKeyData = json['additional_key_deta'] != null
        ? AdditionalKeyData.fromJson(json['additional_key_deta'])
        : null;
    inviteId = json['invite_id'];
    type = json['type'];
    sessionId = json['sessionId'];
    token = json['token'];
    tokboxApiKey = json['tokbox_apiKey'];
    tokboxApiSecret = json['tokbox_apiSecret'];
  }
}

class AdditionalKeyData {
  String? id;
  String? aId;
  String? accessToken;
  String? accessToken2;
  String? roomName;

  AdditionalKeyData({
    this.id,
    this.aId,
    this.accessToken,
    this.accessToken2,
    this.roomName,
  });

  AdditionalKeyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aId = json['a_id'];
    accessToken = json['access_token'];
    accessToken2 = json['access_token2'];
    roomName = json['room_name'];
  }
}
