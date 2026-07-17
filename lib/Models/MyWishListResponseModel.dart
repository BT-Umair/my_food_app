class MyWishListResponseModel {
  bool? status;
  String? message;
  Data? data;

  MyWishListResponseModel({this.status, this.message, this.data});

  MyWishListResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? sId;
  String? wishlistId;
  String? name;
  String? about;
  int? price;
  String? image;
  double? rating; // Yeh double? hi rahega, bas parsing badal rahe hain
  bool? isAvailable;
  String? type;
  String? mealtype;
  Restaurant? restaurant;

  GetData({
    this.createdAt,
    this.sId,
    this.wishlistId,
    this.name,
    this.about,
    this.price,
    this.image,
    this.rating,
    this.isAvailable,
    this.type,
    this.mealtype,
    this.restaurant,
  });

  GetData.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    sId = json['_id'];
    wishlistId = json['wishlistId'];
    name = json['name'];
    about = json['about'];
    price = json['price'];
    image = json['image'];

    // Galti Fixed: Is line ko badla hai taaki int aur double dono handle ho sakein
    rating = json['rating'] != null ? double.parse(json['rating'].toString()) : null;

    isAvailable = json['isAvailable'];
    type = json['type'];
    mealtype = json['mealtype'];
    restaurant = json['restaurant'] != null ? new Restaurant.fromJson(json['restaurant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    data['wishlistId'] = this.wishlistId;
    data['name'] = this.name;
    data['about'] = this.about;
    data['price'] = this.price;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['isAvailable'] = this.isAvailable;
    data['type'] = this.type;
    data['mealtype'] = this.mealtype;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
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
