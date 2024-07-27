import 'package:teleprac/core/const/links.dart';
import 'package:html_unescape/html_unescape.dart';

class BlogsModel {
  String? id;
  String? userId;
  String? title;
  String? slug;
  String? description;
  String? keywords;
  String? category;
  String? subcategory;
  String? optionalUrl;
  String? uploadImageUrl;
  String? uploadPreviewImageUrl;
  String? content;
  String? postBy;
  String? postCustomUser;
  String? createdDate;
  String? status;
  String? isVerified;
  String? isViewed;
  String? blogLink;

  BlogsModel({
    this.id,
    this.userId,
    this.title,
    this.slug,
    this.description,
    this.keywords,
    this.category,
    this.subcategory,
    this.optionalUrl,
    this.uploadImageUrl,
    this.uploadPreviewImageUrl,
    this.content,
    this.postBy,
    this.postCustomUser,
    this.createdDate,
    this.status,
    this.isVerified,
    this.isViewed,
    this.blogLink,
  });

  BlogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    keywords = json['keywords'];
    category = json['category'];
    subcategory = json['subcategory'];
    optionalUrl = json['optional_url'];
    uploadImageUrl = '${AppLinks.baseUrl}/${json['upload_image_url']}';
    uploadPreviewImageUrl =
        '${AppLinks.baseUrl}/${json['upload_preview_image_url']}';
    content = HtmlUnescape().convert(json['content']);
    postBy = json['post_by'];
    postCustomUser = json['post_custom_user'];
    createdDate = json['created_date'];
    status = json['status'];
    isVerified = json['is_verified'];
    isViewed = json['is_viewed'];
    blogLink = '${AppLinks.blog}/$slug';
  }
}
