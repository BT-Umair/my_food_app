class EditAddressRequestModel {
  final String? id;
  final String fullName;
  final String phone;
  final String addressLine;
  final String city;
  final String state;
  final String pincode;
  final String landmark;
  final String addressType;

  EditAddressRequestModel({
    this.id,
    required this.fullName,
    required this.phone,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.pincode,
    required this.landmark,
    required this.addressType,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "phone": phone,
      "addressLine": addressLine,
      "city": city,
      "state": state,
      "pincode": pincode,
      "landmark": landmark,
      "addressType": addressType,
    };
  }
}

class AddAddressRequestModel {
  final String fullName;
  final String phone;
  final String addressLine;
  final String city;
  final String state;
  final String pincode;
  final String landmark;
  final String addressType;

  AddAddressRequestModel({
    required this.fullName,
    required this.phone,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.pincode,
    required this.landmark,
    required this.addressType,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "phone": phone,
      "addressLine": addressLine,
      "city": city,
      "state": state,
      "pincode": pincode,
      "landmark": landmark,
      "addressType": addressType,
    };
  }
}
