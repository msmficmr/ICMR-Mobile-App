class IdTextModel {
  String id;
  String name;
  IdTextModel({required this.id, required this.name});

  factory IdTextModel.fromJson(Map<String, dynamic> e) {
    return IdTextModel(id: e["id"], name: e["name"]);
  }

  @override
  String toString() => name;
}
