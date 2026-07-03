class GetMyOrderResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetMyOrderResponseModel({this.status, this.message, this.data});

  GetMyOrderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Orders>? orders;
  int? count;

  Data({this.orders, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Orders {
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
  double? discount;
  String? paymentMethod;
  String? paymentStatus;
  String? orderStatus;
  String? couponCode;
  String? couponId;
  dynamic deliveryAgent; // Changed from Null? to dynamic for backend data safety
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
  dynamic agent; // Changed from Null? to dynamic for backend data safety

  Orders({
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
    this.agent,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];

    // SAFE NUMERIC PARSING: Prevents type 'int' is not a subtype of 'double?' errors
    totalAmount = json['totalAmount'] != null ? _toDouble(json['totalAmount']) : null;
    gstAndCharges = json['gstAndCharges'] != null ? _toDouble(json['gstAndCharges']) : null;
    discount = json['discount'] != null ? _toDouble(json['discount']) : null;
    distanceKm = json['distanceKm'] != null ? _toDouble(json['distanceKm']) : null;

    itemTotal = json['itemTotal'];
    deliveryFee = json['deliveryFee'];
    baseFee = json['baseFee'];
    surgeCharge = json['surgeCharge'];
    platformFee = json['platformFee'];
    packingCharge = json['packingCharge'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    orderStatus = json['orderStatus'];
    couponCode = json['couponCode'];
    couponId = json['coupon_id'];
    deliveryAgent = json['deliveryAgent'];
    deliveryAddress = json['deliveryAddress'] != null ? DeliveryAddress.fromJson(json['deliveryAddress']) : null;
    deliveryLocation = json['deliveryLocation'] != null ? DeliveryLocation.fromJson(json['deliveryLocation']) : null;
    isSurge = json['isSurge'];
    estimatedTime = json['estimatedTime'];
    cancellationReason = json['cancellationReason'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    restaurant = json['restaurant'] != null ? Restaurant.fromJson(json['restaurant']) : null;
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_id'] = userId;
    data['restaurant_id'] = restaurantId;
    data['totalAmount'] = totalAmount;
    data['itemTotal'] = itemTotal;
    data['deliveryFee'] = deliveryFee;
    data['baseFee'] = baseFee;
    data['surgeCharge'] = surgeCharge;
    data['platformFee'] = platformFee;
    data['packingCharge'] = packingCharge;
    data['gstAndCharges'] = gstAndCharges;
    data['discount'] = discount;
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['orderStatus'] = orderStatus;
    data['couponCode'] = couponCode;
    data['coupon_id'] = couponId;
    data['deliveryAgent'] = deliveryAgent;
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress!.toJson();
    }
    if (deliveryLocation != null) {
      data['deliveryLocation'] = deliveryLocation!.toJson();
    }
    data['distanceKm'] = distanceKm;
    data['isSurge'] = isSurge;
    data['estimatedTime'] = estimatedTime;
    data['cancellationReason'] = cancellationReason;
    data['is_deleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (restaurant != null) {
      data['restaurant'] = restaurant!.toJson();
    }
    data['agent'] = agent;
    return data;
  }

  // Pure helper function to cast int or double safely into standard double format
  static double? _toDouble(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null;
  }
}

class DeliveryAddress {
  String? address;
  Location? location;

  DeliveryAddress({this.address, this.location});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    if (location != null) {
      data['location'] = location!.toJson();
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
    // SAFE LIST PARSING: Replaces .cast<double>() which crashes if any element loads as an int
    if (json['coordinates'] != null) {
      coordinates = List<double>.from(json['coordinates'].map((v) => v is int ? v.toDouble() : v));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class DeliveryLocation {
  dynamic lat; // Changed from Null to dynamic to handle tracking payloads safely
  dynamic lng;
  Null? updatedAt;

  DeliveryLocation({this.lat, this.lng, this.updatedAt});

  DeliveryLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['updatedAt'] = updatedAt;
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
  List<String>? images;

  Restaurant({this.sId, this.name, this.ownerName, this.email, this.phone, this.address, this.images});

  Restaurant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    ownerName = json['ownerName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    // SAFE LIST PARSING: Map values gracefully instead of strict casting
    if (json['images'] != null) {
      images = List<String>.from(json['images'].map((v) => v.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['ownerName'] = ownerName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['images'] = images;
    return data;
  }
}
