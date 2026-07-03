class GetAllAddressListResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetAllAddressListResponseModel({this.status, this.message, this.data});

  GetAllAddressListResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Addresses>? addresses;
  int? count;

  Data({this.addresses, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Addresses {
  String? sId;
  String? userId;
  String? fullName;
  String? phone;
  String? addressLine;
  String? city;
  String? state;
  String? pincode;
  String? landmark;
  String? addressType;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  Addresses({
    this.sId,
    this.userId,
    this.fullName,
    this.phone,
    this.addressLine,
    this.city,
    this.state,
    this.pincode,
    this.landmark,
    this.addressType,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  Addresses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    fullName = json['fullName'];
    phone = json['phone'];
    addressLine = json['addressLine'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    addressType = json['addressType'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['addressType'] = this.addressType;
    data['isDefault'] = this.isDefault;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
