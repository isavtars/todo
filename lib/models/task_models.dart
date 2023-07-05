class Task {
  final int? id;
  final String title, date, startTime, endTime, reminder, reapert, note;

  final int? isComplited;
  final int color;

  Task(
      {required this.title,
      required this.note,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.reminder,
      required this.reapert,
      required this.color,
      this.id,
      this.isComplited});

  //to jsons
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "date": date,
        "startTime": startTime,
        'endTime': endTime,
        "reminder": reminder,
        "reapert": reapert,
        "color": color,
        "isComplited": isComplited
      };

// jsonsDecodes
  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
        id: map['id'],
        title: map['title'],
        note: map['note'],
        date: map['date'],
        startTime: map['startTime'],
        endTime: map['endTime'],
        reminder: map['reminder'],
        reapert: map['reapert'],
        color: map['color'],
        isComplited: map['isComplited']);
  }
}
