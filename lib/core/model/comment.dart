import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String? title;
  final String? date;

  const CommentModel({
    this.title,
    this.date,
  });

  CommentModel copyWith({
    String? title,
    String? date,
  }) =>
      CommentModel(
        title: title ?? this.title,
        date: date ?? this.date,
      );

  CommentModel.fromJson(Map<String, Object> json)
      : this.title = json['title'] as String?,
        this.date = json['date'] as String?;

  Map<String, dynamic> toJson({CommentModel? commentModel}) => {
        'title': title ?? this.title,
        'date': date ?? this.date,
      };

  CommentModel.fromSnapshot(
    DocumentSnapshot element,
  )   : this.title = element.data()!['title'],
        this.date = element.data()!['date'];
}
