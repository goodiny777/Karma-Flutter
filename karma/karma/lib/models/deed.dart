final String tableDeed = 'Deed';
final String columnDeedId = 'id';
final String columnName = 'name';
final String columnDescription = 'description';
final String columnType = 'type';
final String columnValue = 'value';
final String columnDate = 'date';

class Deed {
  int? id;
  String? name;
  String? description;
  bool? type;
  int? value;
  DateTime? date;

  Deed(
      {this.id, this.name, this.description, this.type, this.value, this.date});

  factory Deed.fromMap(Map<String, dynamic> json) => new Deed(
      id: json[columnDeedId],
      name: json[columnName],
      description: json[columnDescription],
      type: json[columnType] == 1,
      value: json[columnValue],
      date: DateTime.fromMillisecondsSinceEpoch(json[columnDate]));

  Map<String, dynamic> toMap() => {
        columnDeedId: id,
        columnName: name,
        columnDescription: description,
        columnType: type,
        columnValue: value,
        columnDate: date?.millisecondsSinceEpoch
      };
}
