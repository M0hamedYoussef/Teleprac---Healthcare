import 'package:html/parser.dart';
import 'package:teleprac/core/const/links.dart';

class OffersModel {
  List<PIdModel>? pId;
  List? allProductsIds;
  String? id;
  String? image;
  String? title;
  String? type; // 0 : Pharmacy Offers , 1 : Diagnostic Offers
  String? contant;

  OffersModel({
    this.pId,
    this.id,
    this.image,
    this.title,
    this.type,
    this.contant,
    this.allProductsIds,
  });

  OffersModel.fromJson(Map<String, dynamic> json) {
    if (json['p_id'] != null) {
      pId = <PIdModel>[];
      json['p_id'].forEach((element) {
        pId!.add(PIdModel.fromJson(element));
      });
    }
    if (pId != null) {
      allProductsIds = [];
      for (PIdModel element in pId!) {
        allProductsIds!.add(element.pId);
      }
    }
    id = json['id'];
    image = '${AppLinks.baseUrl}/${json['image']}';
    title = json['title'];
    type = json['type'];
    // contant = json['contant'];
    contant = parse(json['contant']).body!.text;
  }
}

class PIdModel {
  String? id;
  String? pId;
  String? oId;

  PIdModel({this.id, this.pId, this.oId});

  PIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pId = json['p_id'];
    oId = json['o_id'];
  }
}
