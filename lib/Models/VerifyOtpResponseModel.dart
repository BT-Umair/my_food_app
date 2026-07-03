class VerifyOtpResponseModel {
  bool? status;
  String? message;
  Data? data;

  VerifyOtpResponseModel({this.status, this.message, this.data});

  VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['status'] = status;
    dataMap['message'] = message;
    // Safe: Uses ?. instead of !
    dataMap['data'] = data?.toJson();
    return dataMap;
  }
}

class Data {
  bool? isNewUser;
  User? user;
  String? token;

  Data({this.isNewUser, this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    isNewUser = json['isNewUser'];
    user = json['customer'] != null ? User.fromJson(json['customer']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['isNewUser'] = isNewUser;
    dataMap['customer'] = user?.toJson();
    dataMap['token'] = token;
    return dataMap;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? phoneNumber;
  String? avatar;
  dynamic address;
  String? city;
  String? status;
  bool? isVerified;
  String? role;
  String? createdAt;

  User({
    this.sId,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.address,
    this.city,
    this.status,
    this.isVerified,
    this.role,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    avatar = json['avatar'];
    address = json['address'];
    city = json['city'];
    status = json['status'];
    isVerified = json['is_verified'];
    role = json['role'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    dataMap['_id'] = sId;
    dataMap['name'] = name;
    dataMap['email'] = email;
    dataMap['phoneNumber'] = phoneNumber;
    dataMap['avatar'] = avatar;
    dataMap['address'] = address;
    dataMap['city'] = city;
    dataMap['status'] = status;
    dataMap['is_verified'] = isVerified;
    dataMap['role'] = role;
    dataMap['createdAt'] = createdAt;
    return dataMap;
  }
}
