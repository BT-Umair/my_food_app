class RestaurantSaveResponseModel {
  bool? status;
  String? message;
  Data? data;

  RestaurantSaveResponseModel({this.status, this.message, this.data});

  RestaurantSaveResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? restaurantId;
  bool? isSaved;
  String? savedId;

  Data({this.restaurantId, this.isSaved, this.savedId});

  Data.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    isSaved = json['isSaved'];
    savedId = json['savedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    data['isSaved'] = this.isSaved;
    data['savedId'] = this.savedId;
    return data;
  }
}
