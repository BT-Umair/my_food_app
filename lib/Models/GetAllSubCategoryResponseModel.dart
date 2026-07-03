class GetAllSubCategoryResponseModel {
  bool? status;
  String? message;
  Data? data;

  GetAllSubCategoryResponseModel({this.status, this.message, this.data});

  GetAllSubCategoryResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Subcategory>? subcategory;
  int? count;

  Data({this.subcategory, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new Subcategory.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Subcategory {
  String? sId;
  String? name;
  String? categoryId;
  String? subcategoryImage;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Subcategory({this.sId, this.name, this.categoryId, this.subcategoryImage, this.description, this.status, this.createdAt, this.updatedAt});

  Subcategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'];
    subcategoryImage = json['subcategoryImage'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    data['subcategoryImage'] = this.subcategoryImage;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
