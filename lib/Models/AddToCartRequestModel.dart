class AddToCartRequestModel {
  String? menuId;
  String? restaurantId;
  int? quantity;
  List<Addons>? addons;

  AddToCartRequestModel({this.menuId, this.restaurantId, this.quantity, this.addons});

  AddToCartRequestModel.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    restaurantId = json['restaurant_id'];
    quantity = json['quantity'];
    if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons!.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['restaurant_id'] = this.restaurantId;
    data['quantity'] = this.quantity;
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addons {
  String? addonGroupId;
  String? optionId;
  int? quantity;

  Addons({this.addonGroupId, this.optionId, this.quantity});

  Addons.fromJson(Map<String, dynamic> json) {
    addonGroupId = json['addon_group_id'] ?? json['addon_group_id'];
    optionId = json['option_id'] ?? json['option_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addon_group_id'] = addonGroupId;
    data['option_id'] = optionId;
    data['quantity'] = quantity;

    return data;
  }
}
