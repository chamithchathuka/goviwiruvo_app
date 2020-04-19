class VegetableLoad {
  int id;
  String code;
  String description;
  String image;

  VegetableLoad({this.id, this.code, this.description, this.image});

  VegetableLoad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}