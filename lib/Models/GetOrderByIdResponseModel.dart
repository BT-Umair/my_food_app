class GetOrderByIdResponseModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetOrderByIdResponseModel({this.status, this.message, this.data});

  GetOrderByIdResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? restaurantId;
  double? totalAmount;
  int? itemTotal;
  int? deliveryFee;
  int? baseFee;
  int? surgeCharge;
  int? platformFee;
  int? packingCharge;
  double? gstAndCharges;
  int? discount;
  String? paymentMethod;
  String? paymentStatus;
  String? orderStatus;
  String? couponCode;
  Null? couponId;
  Null? deliveryAgent;
  DeliveryAddress? deliveryAddress;
  DeliveryLocation? deliveryLocation;
  double? distanceKm;
  bool? isSurge;
  int? estimatedTime;
  String? cancellationReason;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  Restaurant? restaurant;

  Data({
    this.sId,
    this.userId,
    this.restaurantId,
    this.totalAmount,
    this.itemTotal,
    this.deliveryFee,
    this.baseFee,
    this.surgeCharge,
    this.platformFee,
    this.packingCharge,
    this.gstAndCharges,
    this.discount,
    this.paymentMethod,
    this.paymentStatus,
    this.orderStatus,
    this.couponCode,
    this.couponId,
    this.deliveryAgent,
    this.deliveryAddress,
    this.deliveryLocation,
    this.distanceKm,
    this.isSurge,
    this.estimatedTime,
    this.cancellationReason,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.restaurant,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    totalAmount = json['totalAmount'];
    itemTotal = json['itemTotal'];
    deliveryFee = json['deliveryFee'];
    baseFee = json['baseFee'];
    surgeCharge = json['surgeCharge'];
    platformFee = json['platformFee'];
    packingCharge = json['packingCharge'];
    gstAndCharges = json['gstAndCharges'];
    discount = json['discount'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    orderStatus = json['orderStatus'];
    couponCode = json['couponCode'];
    couponId = json['coupon_id'];
    deliveryAgent = json['deliveryAgent'];
    deliveryAddress = json['deliveryAddress'] != null ? new DeliveryAddress.fromJson(json['deliveryAddress']) : null;
    deliveryLocation = json['deliveryLocation'] != null ? new DeliveryLocation.fromJson(json['deliveryLocation']) : null;
    distanceKm = json['distanceKm'];
    isSurge = json['isSurge'];
    estimatedTime = json['estimatedTime'];
    cancellationReason = json['cancellationReason'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    restaurant = json['restaurant'] != null ? new Restaurant.fromJson(json['restaurant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['totalAmount'] = this.totalAmount;
    data['itemTotal'] = this.itemTotal;
    data['deliveryFee'] = this.deliveryFee;
    data['baseFee'] = this.baseFee;
    data['surgeCharge'] = this.surgeCharge;
    data['platformFee'] = this.platformFee;
    data['packingCharge'] = this.packingCharge;
    data['gstAndCharges'] = this.gstAndCharges;
    data['discount'] = this.discount;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatus'] = this.paymentStatus;
    data['orderStatus'] = this.orderStatus;
    data['couponCode'] = this.couponCode;
    data['coupon_id'] = this.couponId;
    data['deliveryAgent'] = this.deliveryAgent;
    if (this.deliveryAddress != null) {
      data['deliveryAddress'] = this.deliveryAddress!.toJson();
    }
    if (this.deliveryLocation != null) {
      data['deliveryLocation'] = this.deliveryLocation!.toJson();
    }
    data['distanceKm'] = this.distanceKm;
    data['isSurge'] = this.isSurge;
    data['estimatedTime'] = this.estimatedTime;
    data['cancellationReason'] = this.cancellationReason;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    return data;
  }
}

class DeliveryAddress {
  String? address;
  Location? location;

  DeliveryAddress({this.address, this.location});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class DeliveryLocation {
  Null? lat;
  Null? lng;
  Null? updatedAt;

  DeliveryLocation({this.lat, this.lng, this.updatedAt});

  DeliveryLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Restaurant {
  String? sId;
  String? name;
  String? ownerName;
  String? email;
  String? phone;
  String? address;

  Restaurant({this.sId, this.name, this.ownerName, this.email, this.phone, this.address});

  Restaurant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    ownerName = json['ownerName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['ownerName'] = this.ownerName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
