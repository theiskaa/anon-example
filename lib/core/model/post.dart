import 'package:anon/core/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String userID;
  final String postID;
  final String title;
  final String content;
  final List<dynamic> comments;
  final String color;

  const PostModel({
    this.userID,
    this.postID,
    this.title,
    this.content,
    this.comments,
    this.color,
  });

  PostModel copyWith({
    String userID,
    String postID,
    String title,
    String content,
    List<dynamic> comments,
    String color,
  }) =>
      PostModel(
        userID: userID ?? this.userID,
        postID: postID ?? this.postID,
        title: title ?? this.title,
        content: content ?? this.content,
        comments: comments ?? this.comments,
        color: color ?? this.color,
      );

  PostModel.fromJson(dynamic json)
      : this.userID = json['userID'],
        this.postID = json['postID'],
        this.title = json['title'],
        this.content = json['content'],
        this.comments = json['comments'],
        this.color = json['color'];

  Map<String, dynamic> toJson({PostModel postModel}) => {
        'userID': userID ?? postModel.userID,
        'postID': postID ?? postModel.postID,
        'title': title ?? postModel.title,
        'content': content ?? postModel.content,
        'comments': comments ?? postModel.comments,
        'color': color ?? postModel.color,
      };

  PostModel.fromSnapshot(
    DocumentSnapshot element, [
    List<CommentModel> comments,
  ])  : this.userID = element.data()['userID'],
        this.postID = element.data()['postID'],
        this.title = element.data()['title'],
        this.content = element.data()['content'],
        this.comments = comments,
        this.color = element.data()['color'];
}
