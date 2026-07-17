class PlaceOrderRequestModel {
  String? paymentMethod;
  PaymentDetails? paymentDetails;
  String? addressId;
  DeliveryAddress? deliveryAddress;

  PlaceOrderRequestModel({this.paymentMethod, this.paymentDetails, this.addressId, this.deliveryAddress});

  PlaceOrderRequestModel.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['paymentMethod'];
    paymentDetails = json['paymentDetails'] != null ? new PaymentDetails.fromJson(json['paymentDetails']) : null;
    addressId = json['address_id'];
    deliveryAddress = json['deliveryAddress'] != null ? new DeliveryAddress.fromJson(json['deliveryAddress']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentMethod'] = this.paymentMethod;
    if (this.paymentDetails != null) {
      data['paymentDetails'] = this.paymentDetails!.toJson();
    }
    data['address_id'] = this.addressId;
    if (this.deliveryAddress != null) {
      data['deliveryAddress'] = this.deliveryAddress!.toJson();
    }
    return data;
  }
}

class PaymentDetails {
  String? upiId;

  PaymentDetails({this.upiId});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    upiId = json['upiId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upiId'] = this.upiId;
    return data;
  }
}

class DeliveryAddress {
  String? address;
  double? lat;
  double? lng;

  DeliveryAddress({this.address, this.lat, this.lng});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
