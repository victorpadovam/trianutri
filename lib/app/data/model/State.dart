class StateModel {
  int id;
  String name;
  String identifier;

  StateModel({required this.id, required this.name, required this.identifier});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        id: json['id'], name: json['name'], identifier: json['identifier']);
  }
}
