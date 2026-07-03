class GetAllActiveCouponResponseModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetAllActiveCouponResponseModel({this.status, this.message, this.data});

  GetAllActiveCouponResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? code;
  String? discountType;
  int? discountValue;
  int? minOrderAmount;
  int? maxDiscount;
  String? expiryDate;
  String? description;

  Data({this.sId, this.code, this.discountType, this.discountValue, this.minOrderAmount, this.maxDiscount, this.expiryDate, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    minOrderAmount = json['minOrderAmount'];
    maxDiscount = json['maxDiscount'];
    expiryDate = json['expiryDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['code'] = this.code;
    data['discountType'] = this.discountType;
    data['discountValue'] = this.discountValue;
    data['minOrderAmount'] = this.minOrderAmount;
    data['maxDiscount'] = this.maxDiscount;
    data['expiryDate'] = this.expiryDate;
    data['description'] = this.description;
    return data;
  }
}
