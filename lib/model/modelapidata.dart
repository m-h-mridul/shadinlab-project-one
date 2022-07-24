// To parse this JSON data, do
//
//     final userRegistationInfo = userRegistationInfoFromMap(jsonString);

import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'modelapidata.g.dart';

UserSentInfo userRegistationInfoFromMap(String str) =>
    UserSentInfo.fromMap(json.decode(str));

String userRegistationInfoToMap(UserSentInfo data) => json.encode(data.toMap());
String PostRegistationInfoToMap(Post data) => json.encode(data.toMap());

class UserSentInfo {
  UserSentInfo({
    required this.status,
    required this.message,
    required this.count,
    required this.error,
    required this.posts,
  });

  final String status;
  final String message;
  final int count;
  final bool error;
  final List<Post> posts;

  factory UserSentInfo.fromMap(Map<String, dynamic> json) => UserSentInfo(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        error: json["error"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "count": count,
        "error": error,
        "posts": List<dynamic>.from(posts.map((x) => x.toMap())),
      };
}

@HiveType(typeId: 1)
class Post {
  Post({
    required this.id,
    required this.title,
    required this.body,
  });
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );
  @HiveField(4)
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
