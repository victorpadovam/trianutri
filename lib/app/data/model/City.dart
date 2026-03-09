class CityModel {
  int id;
  String name;
  int stateId;

  CityModel({required this.id, required this.name, required this.stateId});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        id: json['id'], name: json['name'], stateId: json['state_id']);
  }
}
