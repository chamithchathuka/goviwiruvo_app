class LoginRequestDTO {
  String phoneNo;
  String password;

  LoginRequestDTO({this.phoneNo, this.password});

  LoginRequestDTO.fromJson(Map<String, dynamic> json) {
    phoneNo = json['phoneNo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNo'] = this.phoneNo;
    data['password'] = this.password;
    return data;
  }
}