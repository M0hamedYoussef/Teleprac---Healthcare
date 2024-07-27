class MessageModel {
  String? chatTime;
  String? type;
  String? fileName;
  String? msgType;
  String? chatFrom;
  String? chatTo;
  String? fromUserName;
  String? toUserName;
  String? profileFromImage;
  String? profileToImage;
  String? content;

  MessageModel({
    this.chatTime,
    this.type,
    this.fileName,
    this.msgType,
    this.chatFrom,
    this.chatTo,
    this.fromUserName,
    this.toUserName,
    this.profileFromImage,
    this.profileToImage,
    this.content,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    chatTime = json['chat_time'];
    type = json['type'];
    fileName = json['file_name'];
    msgType = json['msg_type'];
    chatFrom = json['chat_from'];
    chatTo = json['chat_to'];
    fromUserName = json['from_user_name'];
    toUserName = json['to_user_name'];
    profileFromImage = json['profile_from_image'];
    profileToImage = json['profile_to_image'];
    content = json['content'];
  }
}
