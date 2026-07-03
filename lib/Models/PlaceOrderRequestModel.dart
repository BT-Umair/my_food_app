class PlaceOrderRequestModel {
  String? paymentMethod;
  DeliveryAddress? deliveryAddress;

  PlaceOrderRequestModel({this.paymentMethod, this.deliveryAddress});

  PlaceOrderRequestModel.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['paymentMethod'];
    deliveryAddress = json['deliveryAddress'] != null ? new DeliveryAddress.fromJson(json['deliveryAddress']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentMethod'] = this.paymentMethod;
    if (this.deliveryAddress != null) {
      data['deliveryAddress'] = this.deliveryAddress!.toJson();
    }
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
