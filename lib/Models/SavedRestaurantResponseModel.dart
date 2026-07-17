class SavedRestaurantResponseModel {
  bool? status;
  String? message;
  Data? data;

  SavedRestaurantResponseModel({this.status, this.message, this.data});

  SavedRestaurantResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? savedId;
  String? name;
  String? ownerName;
  List<String>? images;
  String? address;
  String? city;
  int? rating;
  String? cuisineType;
  bool? isOpen;

  GetData({
    this.createdAt,
    this.sId,
    this.savedId,
    this.name,
    this.ownerName,
    this.images,
    this.address,
    this.city,
    this.rating,
    this.cuisineType,
    this.isOpen,
  });

  GetData.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    sId = json['_id'];
    savedId = json['savedId'];
    name = json['name'];
    ownerName = json['ownerName'];
    images = json['images'].cast<String>();
    address = json['address'];
    city = json['city'];
    rating = json['rating'];
    cuisineType = json['cuisineType'];
    isOpen = json['isOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['_id'] = this.sId;
    data['savedId'] = this.savedId;
    data['name'] = this.name;
    data['ownerName'] = this.ownerName;
    data['images'] = this.images;
    data['address'] = this.address;
    data['city'] = this.city;
    data['rating'] = this.rating;
    data['cuisineType'] = this.cuisineType;
    data['isOpen'] = this.isOpen;
    return data;
  }
}
