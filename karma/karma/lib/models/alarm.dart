final String tableAlarm = 'Alarm';
final String columnId = 'id';
final String columnAlarmDescription = 'description';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';

class AlarmInfo {
  int? id;
  String? description;
  DateTime? alarmDateTime;
  bool? isPending;

  AlarmInfo({this.id, this.description, this.alarmDateTime, this.isPending});

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
      id: json[columnId],
      description: json[columnAlarmDescription],
      alarmDateTime: DateTime.parse(json[columnDateTime]),
      isPending: json[columnPending] == 1);

  Map<String, dynamic> toMap() => {
        columnId: id,
        columnAlarmDescription: description,
        columnDateTime: alarmDateTime?.toIso8601String(),
        columnPending: isPending
      };
}
