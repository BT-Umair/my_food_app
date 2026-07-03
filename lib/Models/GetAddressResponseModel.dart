class GetAddressResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetAddressResponseModel({this.status, this.message, this.data});

  GetAddressResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  String? fullName;
  String? phone;
  String? addressLine;
  String? city;
  String? state;
  String? pincode;
  String? landmark;
  Null lat;
  Null lng;
  String? addressType;
  bool? isDefault;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.userId,
    this.fullName,
    this.phone,
    this.addressLine,
    this.city,
    this.state,
    this.pincode,
    this.landmark,
    this.lat,
    this.lng,
    this.addressType,
    this.isDefault,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    fullName = json['fullName'];
    phone = json['phone'];
    addressLine = json['addressLine'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    lat = json['lat'];
    lng = json['lng'];
    addressType = json['addressType'];
    isDefault = json['isDefault'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['addressLine'] = this.addressLine;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['addressType'] = this.addressType;
    data['isDefault'] = this.isDefault;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
