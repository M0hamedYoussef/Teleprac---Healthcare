import 'package:html/parser.dart';
import 'package:teleprac/core/const/links.dart';

class NotificationModel {
  String? title;
  String? message;
  String? isViewed;
  String? user;
  String? userTo;
  String? image;

  NotificationModel({
    this.title,
    this.message,
    this.isViewed,
    this.user,
    this.userTo,
    this.image,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = parse(json['message']).body!.text;
    isViewed = json['is_viewed'];
    user = json['user'];
    userTo = json['user_to'];
    image = '${AppLinks.baseUrl}/${json['image']}';
  }
}
