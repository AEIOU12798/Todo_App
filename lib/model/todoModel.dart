class TodoModel{
  int id;
  String Title;
  String Description;
  String date;
  String time;

  TodoModel({
    required this.id,
    required this.Title,
    required this.Description,
    required this.date,
    required this.time,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title':Title,
      'date': date,
      'time': time,
      'description': Description,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      date: map['date'],
      time: map['time'],
      Title: map['title'],
      Description: map['description'],
    );
  }
}