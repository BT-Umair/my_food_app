// Data Transfer one Viewmodel To Another Viewmodel is Known as Repository Work.
class LoginRepository {
  String phoneNumber = "";

  void setPhoneNumber(String number) {
    phoneNumber = number;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }
}
