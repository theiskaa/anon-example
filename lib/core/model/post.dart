class PostModel {
  final String id;
  final String content;

  const PostModel({
    this.id,
    this.content,
  });

  PostModel copyWith({
    String id,
    String content,
  }) =>
      PostModel(
        id: id ?? this.id,
        content: content ?? this.content,
      );

  PostModel.fromJson(Map<String, String> json)
      : this.id = json['id'],
        this.content = json['content'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
      };
}
