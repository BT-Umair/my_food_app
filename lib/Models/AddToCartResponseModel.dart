class AddToCartResponseModel {
  bool? status;
  String? message;
  Data? data;

  AddToCartResponseModel({this.status, this.message, this.data});

  AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? itemTotal;
  int? deliveryFee;
  int? baseFee;
  int? surgeCharge;
  int? platformFee;
  int? packingCharge;
  double? discount;
  double? gstRate;
  double? gstAndCharges;
  double? totalAmount;
  String? couponCode;
  int? distanceKm;
  bool? isSurge;
  bool? freeDelivery;
  String? createdAt;
  Restaurant? restaurant;
  List<Items>? items;
  Coupon? coupon;

  Data({
    this.sId,
    this.itemTotal,
    this.deliveryFee,
    this.baseFee,
    this.surgeCharge,
    this.platformFee,
    this.packingCharge,
    this.discount,
    this.gstRate,
    this.gstAndCharges,
    this.totalAmount,
    this.couponCode,
    this.distanceKm,
    this.isSurge,
    this.freeDelivery,
    this.createdAt,
    this.restaurant,
    this.items,
    this.coupon,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemTotal = json['itemTotal'];
    deliveryFee = json['deliveryFee'];
    baseFee = json['baseFee'];
    surgeCharge = json['surgeCharge'];
    platformFee = json['platformFee'];
    packingCharge = json['packingCharge'];
    discount = json['discount'];
    gstRate = json['gstRate'];
    gstAndCharges = json['gstAndCharges'];
    totalAmount = json['totalAmount'];
    couponCode = json['couponCode'];
    distanceKm = json['distanceKm'];
    isSurge = json['isSurge'];
    freeDelivery = json['freeDelivery'];
    createdAt = json['createdAt'];
    restaurant = json['restaurant'] != null ? new Restaurant.fromJson(json['restaurant']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    coupon = json['coupon'] != null ? new Coupon.fromJson(json['coupon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['itemTotal'] = this.itemTotal;
    data['deliveryFee'] = this.deliveryFee;
    data['baseFee'] = this.baseFee;
    data['surgeCharge'] = this.surgeCharge;
    data['platformFee'] = this.platformFee;
    data['packingCharge'] = this.packingCharge;
    data['discount'] = this.discount;
    data['gstRate'] = this.gstRate;
    data['gstAndCharges'] = this.gstAndCharges;
    data['totalAmount'] = this.totalAmount;
    data['couponCode'] = this.couponCode;
    data['distanceKm'] = this.distanceKm;
    data['isSurge'] = this.isSurge;
    data['freeDelivery'] = this.freeDelivery;
    data['createdAt'] = this.createdAt;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.coupon != null) {
      data['coupon'] = this.coupon!.toJson();
    }
    return data;
  }
}

class Restaurant {
  String? sId;
  String? name;
  String? address;

  Restaurant({this.sId, this.name, this.address});

  Restaurant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class Items {
  String? sId;
  String? cartId;
  String? userId;
  String? restaurantId;
  String? menuId;
  String? name;
  dynamic price;
  String? image;
  String? variant;
  List<Addon>? addons;
  int? quantity;
  dynamic itemTotal;
  int? iV;

  Items({
    this.sId,
    this.cartId,
    this.userId,
    this.restaurantId,
    this.menuId,
    this.name,
    this.price,
    this.image,
    this.variant,
    this.addons,
    this.quantity,
    this.itemTotal,
    this.iV,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cartId = json['cart_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    menuId = json['menu_id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    variant = json['variant'];
    if (json['addons'] != null) {
      addons = <Addon>[];
      json['addons'].forEach((v) {
        addons!.add(Addon.fromJson(v));
      });
    }

    quantity = json['quantity'];
    itemTotal = json['itemTotal'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['cart_id'] = cartId;
    data['user_id'] = userId;
    data['restaurant_id'] = restaurantId;
    data['menu_id'] = menuId;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['variant'] = variant;
    if (addons != null) {
      data['addons'] = addons!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    data['itemTotal'] = itemTotal;
    data['__v'] = iV;
    return data;
  }
}

class Coupon {
  String? sId;
  String? code;
  String? discountType;
  int? discountValue;
  int? minOrderAmount;
  int? maxDiscount;
  String? expiryDate;
  String? description;

  Coupon({this.sId, this.code, this.discountType, this.discountValue, this.minOrderAmount, this.maxDiscount, this.expiryDate, this.description});

  Coupon.fromJson(Map<String, dynamic> json) {
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

class Addon {
  String? sId;
  String? name;
  dynamic price;

  Addon({this.sId, this.name, this.price});

  Addon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
