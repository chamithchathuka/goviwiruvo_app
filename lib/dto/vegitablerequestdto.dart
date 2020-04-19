class VegetableRequest {
  String name;
  String address;
  String phone;
  String whatsapp;
  double lat;
  double lon;
  Connector connector;
  List<Vegset> vegset;

  VegetableRequest(
      {this.name,
        this.address,
        this.phone,
        this.whatsapp,
        this.lat,
        this.lon,
        this.connector,
        this.vegset});

  VegetableRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    lat = json['lat'];
    lon = json['lon'];
    connector = json['connector'] != null
        ? new Connector.fromJson(json['connector'])
        : null;
    if (json['vegset'] != null) {
      vegset = new List<Vegset>();
      json['vegset'].forEach((v) {
        vegset.add(new Vegset.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    if (this.connector != null) {
      data['connector'] = this.connector.toJson();
    }
    if (this.vegset != null) {
      data['vegset'] = this.vegset.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Connector {
  String name;
  String phone;
  double lat;
  double lon;

  Connector({this.name, this.phone, this.lat, this.lon});

  Connector.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Vegset {
  int vegetableId;
  int grade;
  double rate;
  int quantity;
  String date;
  int freePercentage;

  Vegset(
      {this.vegetableId,
        this.grade,
        this.rate,
        this.quantity,
        this.date,
        this.freePercentage});

  Vegset.fromJson(Map<String, dynamic> json) {
    vegetableId = json['vegetableId'];
    grade = json['grade'];
    rate = json['rate'];
    quantity = json['quantity'];
    date = json['date'];
    freePercentage = json['freePercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vegetableId'] = this.vegetableId;
    data['grade'] = this.grade;
    data['rate'] = this.rate;
    data['quantity'] = this.quantity;
    data['date'] = this.date;
    data['freePercentage'] = this.freePercentage;
    return data;
  }
}