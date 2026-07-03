class GetAllMenuItemsResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetAllMenuItemsResponseModel({this.status, this.message, this.data});

  GetAllMenuItemsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }
}

class Data {
  List<Items>? items;
  int? count;

  Data({this.items, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? (json['items'] as List).map((e) => Items.fromJson(e)).toList() : [];

    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {'items': items?.map((e) => e.toJson()).toList(), 'count': count};
  }
}

class Items {
  String? sId;
  String? type;
  String? mealtype;
  String? name;
  String? about;
  String? price;

  String? image;
  double? rating;
  bool? isAvailable;
  List<dynamic>? customizations;
  String? createdAt;
  Restaurant? restaurant;
  Category? category;
  Subcategory? subcategory;

  Items({
    this.sId,
    this.type,
    this.mealtype,
    this.name,
    this.about,
    this.price,
    this.image,
    this.rating,
    this.isAvailable,
    this.customizations,
    this.createdAt,
    this.restaurant,
    this.category,
    this.subcategory,
  });

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    mealtype = json['mealtype'];
    name = json['name'];
    about = json['about'];
    json['price']?.toString();
    price = json['price']?.toString();
    image = json['image'];

    rating = json['rating'] != null ? double.tryParse(json['rating'].toString()) : null;

    isAvailable = json['isAvailable'];

    // if (json['customizations'] != null) {
    //   customizations = <Null>[];
    //   json['customizations'].forEach((v) {
    //     customizations!.add(Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    restaurant = json['restaurant'] != null ? new Restaurant.fromJson(json['restaurant']) : null;
    category = json['category'] != null ? new Category.fromJson(json['category']) : null;
    subcategory = json['subcategory'] != null ? new Subcategory.fromJson(json['subcategory']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.sId;
    data['type'] = this.type;
    data['mealtype'] = this.mealtype;
    data['name'] = this.name;
    data['about'] = this.about;
    data['price'] = this.price;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['isAvailable'] = this.isAvailable;
    if (this.customizations != null) {
      data['customizations'] = this.customizations!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
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

class Category {
  String? sId;
  String? name;
  String? categoryImage;
  String? description;

  Category({this.sId, this.name, this.categoryImage, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    categoryImage = json['categoryImage'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['categoryImage'] = this.categoryImage;
    data['description'] = this.description;
    return data;
  }
}

class Subcategory {
  String? sId;
  String? name;
  String? subcategoryImage;
  String? description;

  Subcategory({this.sId, this.name, this.subcategoryImage, this.description});

  Subcategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    subcategoryImage = json['subcategoryImage'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['subcategoryImage'] = this.subcategoryImage;
    data['description'] = this.description;
    return data;
  }
}
