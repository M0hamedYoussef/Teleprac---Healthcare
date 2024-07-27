import 'package:teleprac/core/const/links.dart';

class SpecializationModel {
  String? id;
  String? specializationImg;
  String? specialization;
  String? sequence;

  SpecializationModel({
    this.id,
    this.specializationImg,
    this.specialization,
    this.sequence,
  });

  SpecializationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specializationImg =
        '${AppLinks.baseUrl}/${json['specialization_img'].toString().replaceAll('https://www.teleprac.com/', '')}';
    specialization = json['specialization'];
    sequence = json['sequence'];
  }
}
