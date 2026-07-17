class ToggleWishListResponseModel {
  bool? status;
  String? message;
  Data? data;

  ToggleWishListResponseModel({this.status, this.message, this.data});

  ToggleWishListResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? menuId;
  bool? isWishlisted;
  String? wishlistId;

  Data({this.menuId, this.isWishlisted, this.wishlistId});

  Data.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    isWishlisted = json['isWishlisted'];
    wishlistId = json['wishlistId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuId'] = this.menuId;
    data['isWishlisted'] = this.isWishlisted;
    data['wishlistId'] = this.wishlistId;
    return data;
  }
}
