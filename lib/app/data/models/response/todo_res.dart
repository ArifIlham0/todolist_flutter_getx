import 'dart:convert';

TodoResponse todoResponseFromJson(String str) =>
    TodoResponse.fromJson(json.decode(str));

String todoResponseToJson(TodoResponse data) => json.encode(data.toJson());

class TodoResponse {
  final int statusCode;
  final bool success;
  final List<Datum> data;

  TodoResponse({
    required this.statusCode,
    required this.success,
    required this.data,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) => TodoResponse(
        statusCode: json["statusCode"],
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String user;
  final String title;
  final String description;
  final bool completed;
  final DateTime time;

  Datum({
    required this.id,
    required this.user,
    required this.title,
    required this.description,
    required this.completed,
    required this.time,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        user: json["user"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "title": title,
        "description": description,
        "completed": completed,
        "time": time.toIso8601String(),
      };
}
