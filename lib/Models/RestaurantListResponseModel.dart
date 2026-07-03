class RestaurantListResponseModel {
  bool? status;
  String? message;
  Data? data;

  RestaurantListResponseModel({this.status, this.message, this.data});

  RestaurantListResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Restaurants>? restaurants;
  int? count;

  Data({this.restaurants, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Restaurants {
  String? sId;
  String? userId;
  String? name;
  String? ownerName;
  String? email;
  String? phone;
  String? address;
  List<dynamic>? image;
  Location? location;
  List<Null>? likes;
  int? rating;
  bool? isOpen;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? pincode;

  Restaurants({
    this.sId,
    this.userId,
    this.name,
    this.ownerName,
    this.email,
    this.phone,
    this.address,
    this.image,
    this.location,
    this.likes,
    this.rating,
    this.isOpen,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pincode,
  });

  Restaurants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    name = json['name'];
    ownerName = json['ownerName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    image = json['images'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;

    if (json['likes'] != null) {
      likes = List<String>.from(json['likes']).cast<Null>();
    }

    rating = json['rating'];
    isOpen = json['isOpen'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['ownerName'] = this.ownerName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['image'] = this.image;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (likes != null) {
      data['likes'] = likes;
    }
    data['rating'] = this.rating;
    data['isOpen'] = this.isOpen;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['pincode'] = this.pincode;
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
