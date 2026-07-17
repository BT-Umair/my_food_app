class GetMenuItemsResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetMenuItemsResponseModel({this.status, this.message, this.data});

  GetMenuItemsResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<GetData>? getData;
  int? count;

  Data({this.getData, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['getData'] != null) {
      getData = <GetData>[];
      json['getData'].forEach((v) {
        getData!.add(new GetData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  int? estimationtime;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Customizations>? customizations;
  bool? isAvailable;
  String? restaurantName;
  String? categoryName;
  String? subcategoryName;
  bool? isWishlist;

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
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customizations,
    this.isAvailable,
    this.restaurantName,
    this.categoryName,
    this.subcategoryName,
    this.isWishlist,
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
    rating = json['rating'] != null ? num.parse(json['rating'].toString()) : null;
    estimationtime = json['estimationtime'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['customizations'] != null) {
      customizations = <Customizations>[];
      json['customizations'].forEach((v) {
        customizations!.add(new Customizations.fromJson(v));
      });
    }
    isAvailable = json['isAvailable'];
    restaurantName = json['restaurantName'];
    categoryName = json['categoryName'];
    subcategoryName = json['subcategoryName'];
    isWishlist = json['isWishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.customizations != null) {
      data['customizations'] = this.customizations!.map((v) => v.toJson()).toList();
    }
    data['isAvailable'] = this.isAvailable;
    data['restaurantName'] = this.restaurantName;
    data['categoryName'] = this.categoryName;
    data['subcategoryName'] = this.subcategoryName;
    data['isWishlist'] = this.isWishlist;
    return data;
  }
}

class Customizations {
  String? sId;
  String? restaurantId;
  String? groupName;
  String? description;
  bool? required;
  int? minSelect;
  int? maxSelect;
  bool? allowQuantity;
  List<Options>? options;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Customizations({
    this.sId,
    this.restaurantId,
    this.groupName,
    this.description,
    this.required,
    this.minSelect,
    this.maxSelect,
    this.allowQuantity,
    this.options,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Customizations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    restaurantId = json['restaurant_id'];
    groupName = json['groupName'];
    description = json['description'];
    required = json['required'];
    minSelect = json['minSelect'];
    maxSelect = json['maxSelect'];
    allowQuantity = json['allowQuantity'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    status = json['status'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['restaurant_id'] = this.restaurantId;
    data['groupName'] = this.groupName;
    data['description'] = this.description;
    data['required'] = this.required;
    data['minSelect'] = this.minSelect;
    data['maxSelect'] = this.maxSelect;
    data['allowQuantity'] = this.allowQuantity;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['is_deleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Options {
  String? name;
  int? price;
  bool? isAvailable;
  bool? isDefault;
  String? sId;

  Options({this.name, this.price, this.isAvailable, this.isDefault, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    isAvailable = json['isAvailable'];
    isDefault = json['isDefault'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['isAvailable'] = this.isAvailable;
    data['isDefault'] = this.isDefault;
    data['_id'] = this.sId;
    return data;
  }
}
