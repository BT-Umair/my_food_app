class TrackOrderResponseModel {
  bool? status;
  String? message;
  Data? data;

  TrackOrderResponseModel({this.status, this.message, this.data});

  TrackOrderResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? orderId;
  String? orderStatus;
  bool? isCancelled;
  bool? isRejected;
  List<Steps>? steps;
  int? estimatedTime;
  Restaurant? restaurant;
  dynamic deliveryAgent; // Fixed: Changed from Null to dynamic
  DeliveryAddress? deliveryAddress;
  DeliveryLocation? deliveryLocation;
  List<OrderItem>? items; // Fixed: Changed from Null to OrderItem
  Pricing? pricing;
  String? paymentMethod;
  String? paymentStatus;
  String? orderedAt;
  dynamic liveTracking; // Fixed: Changed from Null to dynamic

  Data({
    this.orderId,
    this.orderStatus,
    this.isCancelled,
    this.isRejected,
    this.steps,
    this.estimatedTime,
    this.restaurant,
    this.deliveryAgent,
    this.deliveryAddress,
    this.deliveryLocation,
    this.items,
    this.pricing,
    this.paymentMethod,
    this.paymentStatus,
    this.orderedAt,
    this.liveTracking,
  });

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderStatus = json['orderStatus'];
    isCancelled = json['isCancelled'];
    isRejected = json['isRejected'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    estimatedTime = json['estimatedTime'];
    restaurant = json['restaurant'] != null ? Restaurant.fromJson(json['restaurant']) : null;
    deliveryAgent = json['deliveryAgent'];
    deliveryAddress = json['deliveryAddress'] != null ? DeliveryAddress.fromJson(json['deliveryAddress']) : null;
    deliveryLocation = json['deliveryLocation'] != null ? DeliveryLocation.fromJson(json['deliveryLocation']) : null;
    if (json['items'] != null) {
      items = <OrderItem>[]; // Fixed: Maps items safely
      json['items'].forEach((v) {
        items!.add(OrderItem.fromJson(v));
      });
    }
    pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    orderedAt = json['orderedAt'];
    liveTracking = json['liveTracking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['orderStatus'] = orderStatus;
    data['isCancelled'] = isCancelled;
    data['isRejected'] = isRejected;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    data['estimatedTime'] = estimatedTime;
    if (restaurant != null) {
      data['restaurant'] = restaurant!.toJson();
    }
    data['deliveryAgent'] = deliveryAgent;
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress!.toJson();
    }
    if (deliveryLocation != null) {
      data['deliveryLocation'] = deliveryLocation!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList(); // Fixed
    }
    if (pricing != null) {
      data['pricing'] = pricing!.toJson();
    }
    data['paymentMethod'] = paymentMethod;
    data['paymentStatus'] = paymentStatus;
    data['orderedAt'] = orderedAt;
    data['liveTracking'] = liveTracking;
    return data;
  }
}

class Steps {
  String? status;
  String? label;
  String? icon;
  bool? completed;
  bool? active;
  bool? pending;

  Steps({this.status, this.label, this.icon, this.completed, this.active, this.pending});

  Steps.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    label = json['label'];
    icon = json['icon'];
    completed = json['completed'];
    active = json['active'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['label'] = label;
    data['icon'] = icon;
    data['completed'] = completed;
    data['active'] = active;
    data['pending'] = pending;
    return data;
  }
}

// Fixed Placeholder: Replace fields inside this class with your actual API keys
class OrderItem {
  String? id;
  String? name;
  int? quantity;

  OrderItem({this.id, this.name, this.quantity});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}

class Restaurant {
  String? sId;
  String? name;
  String? phone;
  String? address;
  Location? location;

  Restaurant({this.sId, this.name, this.phone, this.address, this.location});

  Restaurant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phone'] = this.phone;
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

class Pricing {
  int? itemTotal;
  int? deliveryFee;
  int? surgeCharge;
  double? gstAndCharges;
  int? discount;
  String? couponCode;
  double? totalAmount;
  bool? isSurge;
  double? distanceKm;

  Pricing({
    this.itemTotal,
    this.deliveryFee,
    this.surgeCharge,
    this.gstAndCharges,
    this.discount,
    this.couponCode,
    this.totalAmount,
    this.isSurge,
    this.distanceKm,
  });

  Pricing.fromJson(Map<String, dynamic> json) {
    itemTotal = json['itemTotal'];
    deliveryFee = json['deliveryFee'];
    surgeCharge = json['surgeCharge'];
    gstAndCharges = json['gstAndCharges'];
    discount = json['discount'];
    couponCode = json['couponCode'];
    totalAmount = json['totalAmount'];
    isSurge = json['isSurge'];
    distanceKm = json['distanceKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemTotal'] = this.itemTotal;
    data['deliveryFee'] = this.deliveryFee;
    data['surgeCharge'] = this.surgeCharge;
    data['gstAndCharges'] = this.gstAndCharges;
    data['discount'] = this.discount;
    data['couponCode'] = this.couponCode;
    data['totalAmount'] = this.totalAmount;
    data['isSurge'] = this.isSurge;
    data['distanceKm'] = this.distanceKm;
    return data;
  }
}
