class UpdateProfileRequestModel {
  String? email;
  String? name;
  String? countryCode;
  String? gender;
  String? phoneNumber;
  String? avtar;

  UpdateProfileRequestModel(
      {this.email,
      this.name,
      this.countryCode,
      this.gender,
      this.phoneNumber,
      this.avtar});

  UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    countryCode = json['countryCode'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    avtar = json['avtar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['avtar'] = this.avtar;
    return data;
  }
}