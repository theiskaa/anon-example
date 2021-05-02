import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String title;
  final String description;

  const CommentModel({
    this.title,
    this.description,
  });

  CommentModel copyWith({
    String title,
    String description,
  }) =>
      CommentModel(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  CommentModel.fromJson(Map<String, Object> json)
      : this.title = json['title'],
        this.description = json['description'];

  CommentModel.fromSnapshot(
    DocumentSnapshot element,
  )   : this.title = element.data()['title'],
        this.description = element.data()['description'];

  Map<String, dynamic> toJson({CommentModel commentModel}) => {
        'title': title ?? this.title,
        'description': description ?? this.description,
      };

  // static String encode(List<CommentModel> commentList) => jsonEncode(
  //       commentList
  //           .map<Map<String, Object>>(
  //             (comment) => CommentModel().toJson(commentModel: comment),
  //           )
  //           .toList(),
  //     );
}
