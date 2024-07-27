class FamilyMemberModel {
  String? id;
  String? userId;
  String? name;
  String? gender;
  String? dob;
  String? contact;
  String? address;
  String? relation;
  String? bloodGroup;
  String? status;
  String? createdAt;
  String? updatedAt;

  FamilyMemberModel({
    this.id,
    this.userId,
    this.name,
    this.gender,
    this.dob,
    this.contact,
    this.address,
    this.relation,
    this.bloodGroup,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
    contact = json['contact'];
    address = json['address'];
    relation = json['relation'];
    bloodGroup = json['blood_group'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
