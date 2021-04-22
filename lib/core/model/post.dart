import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String userID;
  final String title;
  final String content;

  const PostModel({
    this.userID,
    this.title,
    this.content,
  });

  PostModel copyWith({
    String userID,
    String title,
    String content,
  }) =>
      PostModel(
        userID: userID ?? this.userID,
        title: title ?? this.title,
        content: content ?? this.content,
      );

  PostModel.fromJson(Map<String, Object> json)
      : this.userID = json['userID'],
        this.title = json['title'],
        this.content = json['content'];

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'title': title,
        'content': content,
      };

  PostModelEntity toEntity() =>
      PostModelEntity(userID: userID, title: title, content: content);

  static PostModel fromEntity(PostModelEntity entity) {
    return PostModel(
      userID: entity.userID,
      title: entity.title,
      content: entity.content,
    );
  }
}

class PostModelEntity {
  final String userID;
  final String title;
  final String content;

  const PostModelEntity({
    this.userID,
    this.title,
    this.content,
  });

  PostModelEntity copyWith({
    String userID,
    String title,
    String content,
  }) =>
      PostModelEntity(
        userID: userID ?? this.userID,
        title: title ?? this.title,
        content: content ?? this.content,
      );

  PostModelEntity.fromJson(Map<String, Object> json)
      : this.userID = json['userID'],
        this.title = json['title'],
        this.content = json['content'];

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'title': title,
        'content': content,
      };

  PostModelEntity.fromSnapshot(DocumentSnapshot element)
      : this.userID = element.data()['userID'],
        this.title = element.data()['title'],
        this.content = element.data()['content'];
}
