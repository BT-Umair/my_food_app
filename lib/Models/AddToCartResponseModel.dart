class AddToCartResponseModel {
  bool? status;
  String? message;
  dynamic data;

  AddToCartResponseModel({this.status, this.message, this.data});

  AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;

    data['data'] = this.data;

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
  int? discount;
  double? gstRate;
  double? gstAndCharges;
  double? totalAmount;
  String? couponCode;
  int? distanceKm;
  bool? isSurge;
  bool? freeDelivery;
  String? createdAt;
  List<Items>? items;
  Null? coupon;
  Null? restaurant;

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
    this.items,
    this.coupon,
    this.restaurant,
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
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    coupon = json['coupon'];
    restaurant = json['restaurant'];
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
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['coupon'] = this.coupon;
    data['restaurant'] = this.restaurant;
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
  int? price;
  String? image;
  Null? variant;
  List<Addons>? addons;
  int? quantity;
  int? itemTotal;
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
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
    quantity = json['quantity'];
    itemTotal = json['itemTotal'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['menu_id'] = this.menuId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['variant'] = this.variant;
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['itemTotal'] = this.itemTotal;
    data['__v'] = this.iV;
    return data;
  }
}

class Addons {
  String? groupName;
  String? optionName;
  int? price;
  int? quantity;
  String? sId;

  Addons({this.groupName, this.optionName, this.price, this.quantity, this.sId});

  Addons.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    optionName = json['optionName'];
    price = json['price'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['optionName'] = this.optionName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}
