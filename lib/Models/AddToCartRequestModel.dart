class AddToCartRequestModel {
  String? menuId;
  String? restaurantId;
  int? quantity;
  Variant? variant;
  List<Addons>? addons;

  AddToCartRequestModel({this.menuId, this.restaurantId, this.quantity, this.variant, this.addons});

  AddToCartRequestModel.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    restaurantId = json['restaurant_id'];
    quantity = json['quantity'];
    variant = json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
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
    if (this.variant != null) {
      data['variant'] = this.variant!.toJson();
    }
    if (this.addons != null) {
      data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variant {
  String? groupName;
  String? optionName;

  Variant({this.groupName, this.optionName});

  Variant.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    optionName = json['optionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['optionName'] = this.optionName;
    return data;
  }
}

class Addons {
  String? groupName;
  String? optionName;
  int? quantity;

  Addons({this.groupName, this.optionName, this.quantity});

  Addons.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    optionName = json['optionName'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['optionName'] = this.optionName;
    data['quantity'] = this.quantity;
    return data;
  }
}
