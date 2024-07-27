class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? mobileno;
  String? role;
  String? token;
  String? status;
  String? profileimage;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.username,
      this.mobileno,
      this.role,
      this.token,
      this.status,
      this.profileimage});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    mobileno = json['mobileno'];
    role = json['role'];
    token = json['token'];
    status = json['status'];
    profileimage = json['profileimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['mobileno'] = mobileno;
    data['role'] = role;
    data['token'] = token;
    data['status'] = status;
    data['profileimage'] = profileimage;
    return data;
  }
}
