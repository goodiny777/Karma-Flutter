class Deed {
  int id;
  String name;
  String description;
  bool type;
  int value;
  DateTime date;

  Deed(
      {this.id, this.name, this.description, this.type, this.value, this.date});

  factory Deed.fromMap(Map<String, dynamic> json) => new Deed(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      type: json["type"] == 1,
      value: json["value"],
      date: DateTime.fromMicrosecondsSinceEpoch(json["date"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "value": value,
        "date": date.microsecondsSinceEpoch
      };
}
