import 'package:teleprac/core/const/links.dart';

class ReviewModel {
  String? profileimage;
  String? firstName;
  String? lastName;
  String? fullName;
  String? id;
  String? doctorId;
  String? userId;
  String? title;
  String? review;
  String? rating;
  String? createdDate;
  String? timeZone;

  ReviewModel({
    this.profileimage,
    this.firstName,
    this.lastName,
    this.fullName,
    this.id,
    this.doctorId,
    this.userId,
    this.title,
    this.review,
    this.rating,
    this.createdDate,
    this.timeZone,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    profileimage = '${AppLinks.baseUrl}/${json['profileimage']}';
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = '$firstName $lastName';
    id = json['id'];
    doctorId = json['doctor_id'];
    userId = json['user_id'];
    title = json['title'];
    review = json['review'];
    rating = json['rating'];
    createdDate = json['created_date'];
    timeZone = json['time_zone'];
  }
}
