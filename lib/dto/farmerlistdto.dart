class FarmerListDTO {
  List<Farmers> farmers;
  int coordinatorId;

  FarmerListDTO({this.farmers, this.coordinatorId});

  FarmerListDTO.fromJson(Map<String, dynamic> json) {
    if (json['farmers'] != null) {
      farmers = new List<Farmers>();
      json['farmers'].forEach((v) {
        farmers.add(new Farmers.fromJson(v));
      });
    }
    coordinatorId = json['cooridinatorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmers != null) {
      data['farmers'] = this.farmers.map((v) => v.toJson()).toList();
    }
    data['coordinatorId'] = this.coordinatorId;
    return data;
  }
}

class Farmers {
  bool active;
  String address;
  bool delete;
  int id;
  double lat;
  double lon;
  String name;
  String phoneNo;
  int role;
  String whatsappNo;

  Farmers(
      {this.active,
        this.address,
        this.delete,
        this.id,
        this.lat,
        this.lon,
        this.name,
        this.phoneNo,
        this.role,
        this.whatsappNo});

  Farmers.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    address = json['address'];
    delete = json['delete'];
    id = json['id'];
    lat = json['lat'];
    lon = json['lon'];
    name = json['name'];
    phoneNo = json['phoneNo'];
    role = json['role'];
    whatsappNo = json['whatsappNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['address'] = this.address;
    data['delete'] = this.delete;
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['name'] = this.name;
    data['phoneNo'] = this.phoneNo;
    data['role'] = this.role;
    data['whatsappNo'] = this.whatsappNo;
    return data;
  }
}