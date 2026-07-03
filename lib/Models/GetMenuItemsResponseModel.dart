class GetMenuItemsResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetMenuItemsResponseModel({this.status, this.message, this.data});

  GetMenuItemsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<GetData>? getData;
  int? count;

  Data({this.getData, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getData'] != null) {
      getData = <GetData>[];
      json['getData'].forEach((v) {
        getData!.add(GetData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.getData != null) {
      data['getData'] = this.getData!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class GetData {
  String? sId;
  String? restaurantId;
  String? categoryId;
  String? subcategoryId;
  String? type;
  String? mealtype;
  String? name;
  String? about;
  int? price;
  String? image;
  num? rating;
  num? estimationtime; // FIXED: Changed from String? to num? to accept 20 safely
  bool? isAvailable;
  String? status; // FIXED: Changed from int? to String? to accept "ACTIVE" safely
  List<Customization>? customizations;
  String? createdAt;
  String? updatedAt;
  String? restaurantName;
  String? categoryName;
  String? subcategoryName;

  GetData({
    this.sId,
    this.restaurantId,
    this.categoryId,
    this.subcategoryId,
    this.type,
    this.mealtype,
    this.name,
    this.about,
    this.price,
    this.image,
    this.rating,
    this.estimationtime,
    this.isAvailable,
    this.status,
    this.customizations,
    this.createdAt,
    this.updatedAt,
    this.restaurantName,
    this.categoryName,
    this.subcategoryName,
  });

  GetData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    restaurantId = json['restaurantId'];
    categoryId = json['categoryId'];
    subcategoryId = json['subcategoryId'];
    type = json['type'];
    mealtype = json['mealtype'];
    name = json['name'];
    about = json['about'];
    price = json['price'];
    image = json['image'];
    rating = json['rating'];
    estimationtime = json['estimationtime'];
    isAvailable = json['isAvailable'];
    status = json['status'];
    if (json['customizations'] != null) {
      customizations = <Customization>[];
      json['customizations'].forEach((v) {
        customizations!.add(Customization.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    restaurantName = json['restaurantName'];
    categoryName = json['categoryName'];
    subcategoryName = json['subcategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['restaurantId'] = this.restaurantId;
    data['categoryId'] = this.categoryId;
    data['subcategoryId'] = this.subcategoryId;
    data['type'] = this.type;
    data['mealtype'] = this.mealtype;
    data['name'] = this.name;
    data['about'] = this.about;
    data['price'] = this.price;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['estimationtime'] = this.estimationtime;
    data['isAvailable'] = this.isAvailable;
    data['status'] = this.status;
    if (this.customizations != null) {
      data['customizations'] = this.customizations!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['restaurantName'] = this.restaurantName;
    data['categoryName'] = this.categoryName;
    data['subcategoryName'] = this.subcategoryName;
    return data;
  }

  operator [](int other) {}
}

class Customization {
  Customization.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
