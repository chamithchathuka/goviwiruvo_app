class UserDTO {
  String address;
  double lat;
  double lon;
  String name;
  String phoneNo;
  String whatsappNo;
  int role;

  UserDTO(
      {this.address,
        this.lat,
        this.lon,
        this.name,
        this.phoneNo,
        this.whatsappNo,
        this.role});

  UserDTO.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    whatsappNo = json['whatsappNo'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['name'] = this.name;
    data['phoneNo'] = this.phoneNo;
    data['whatsappNo'] = this.whatsappNo;
    data['role'] = this.role;
    return data;
  }
}