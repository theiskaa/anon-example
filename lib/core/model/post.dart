import 'package:anon/core/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String userID;
  final String title;
  final String content;
  final List<dynamic> comments;

  const PostModel({this.userID, this.title, this.content, this.comments});

  PostModel copyWith({
    String userID,
    String title,
    String content,
    List<dynamic> comments,
  }) =>
      PostModel(
        userID: userID ?? this.userID,
        title: title ?? this.title,
        content: content ?? this.content,
        comments: comments ?? this.comments,
      );

  PostModel.fromJson(Map<String, Object> json)
      : this.userID = json['userID'],
        this.title = json['title'],
        this.content = json['content'],
        this.comments = json['comments'];

  Map<String, dynamic> toJson({PostModel postModel}) => {
        'userID': userID ?? postModel.userID,
        'title': title ?? postModel.title,
        'content': content ?? postModel.content,
        'comments': comments ?? postModel.comments,
      };

  PostModel.fromSnapshot(
    DocumentSnapshot element, [
    List<CommentModel> comments,
  ])  : this.userID = element.data()['userID'],
        this.title = element.data()['title'],
        this.content = element.data()['content'],
        this.comments = comments;

  // static String encode(List<PostModel> posts, [String encodedComments]) =>
  //     jsonEncode(
  //       posts
  //           .map<Map<String, Object>>((post) => PostModel()
  //               .toJson(postModel: post.copyWith(comments: [encodedComments])))
  //           .toList(),
  //     );

  // static List<PostModel> decode(String posts, [String comments]) {
  //   var decodedComments;
  //   if (comments != null) {
  //     decodedComments = (json.decode(comments) as List<dynamic>)
  //         .map<CommentModel>((item) => CommentModel.fromJson(item))
  //         .toList();
  //   }

  //   return (json.decode(posts) as List<dynamic>)
  //       .map<PostModel>((item) =>
  //           PostModel.fromJson(item).copyWith(comments: decodedComments ?? []))
  //       .toList();
  // }
}
