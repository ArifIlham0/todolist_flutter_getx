import 'dart:convert';

NyobaResponse nyobaResponseFromJson(String str) =>
    NyobaResponse.fromJson(json.decode(str));

String nyobaResponseToJson(NyobaResponse data) => json.encode(data.toJson());

class NyobaResponse {
  int? statusCode;
  bool? success;
  NyobaData? message;

  NyobaResponse({
    this.statusCode,
    this.success,
    this.message,
  });

  factory NyobaResponse.fromJson(Map<String, dynamic> json) => NyobaResponse(
        statusCode: json["status_code"],
        success: json["success"],
        message: NyobaData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "success": success,
        "message": message?.toJson(),
      };
}

class NyobaData {
  int? id;
  String? title;
  String? description;
  DateTime? time;
  int? completed;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  NyobaData({
    this.id,
    this.title,
    this.description,
    this.time,
    this.completed,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory NyobaData.fromJson(Map<String, dynamic> json) => NyobaData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        time: DateTime.parse(json["time"]),
        completed: json["completed"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "time": time?.toIso8601String(),
        "completed": completed,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
