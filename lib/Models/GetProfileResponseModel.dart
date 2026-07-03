class GetProfileResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetProfileResponseModel({this.status, this.message, this.data});

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseModel(status: json['status'], message: json['message'], data: json['data'] != null ? Data.fromJson(json['data']) : null);
  }
}

class Data {
  String? id;
  String? phoneNumber;
  dynamic countryCode;
  String? name;
  String? email;
  String? avatar;
  dynamic address;
  String? city;
  String? status;
  bool? isVerified;
  DateTime? createdAt;

  Data({
    this.id,
    this.phoneNumber,
    this.countryCode,
    this.name,
    this.email,
    this.avatar,
    this.address,
    this.city,
    this.status,
    this.isVerified,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id']?.toString(),
      phoneNumber: json['phoneNumber']?.toString(),
      countryCode: json['countryCode'],
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      avatar: json['avatar']?.toString(),
      address: json['address'],
      city: json['city']?.toString(),
      status: json['status']?.toString(),
      isVerified: json['is_verified'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }
}
