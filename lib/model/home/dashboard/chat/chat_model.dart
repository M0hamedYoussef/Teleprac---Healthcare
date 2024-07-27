import 'package:teleprac/core/const/links.dart';

class ChatModel {
  String? userid;
  String? role;
  String? firstName;
  String? lastName;
  String? username;
  String? profileimage;
  String? chatdate;
  String? lastchat;
  String? fullName;

  ChatModel({
    this.userid,
    this.role,
    this.firstName,
    this.lastName,
    this.username,
    this.profileimage,
    this.chatdate,
    this.lastchat,
    this.fullName,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = '$firstName $lastName';
    username = json['username'];
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    chatdate = json['chatdate'];
    lastchat = json['lastchat'];
  }
}
