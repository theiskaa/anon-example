import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  PostModel postModel;
  CommentModel commentModel;
  List<CommentModel> commentModelList;

  Map<String, dynamic> postModelJson;

  setUpAll(() {
    commentModel = CommentModel(
      title: 'title',
      date: 'date',
    );

    commentModelList = [
      commentModel,
      commentModel.copyWith(title: 'title1'),
      commentModel.copyWith(title: 'title2'),
    ];

    postModel = PostModel(
      userID: "empty",
      postID: 'AfasRHfuwgFsuwoh23Rfqw',
      title: "title",
      content: 'content',
      comments: commentModelList,
      color: "#F4ECF7",
    );

    postModelJson = {
      'userID': 'empty',
      'postID': "AfasRHfuwgFsuwoh23Rfqw",
      'title': "title",
      'content': "content",
      'comments': commentModelList,
      'color': "#F4ECF7",
    };
  });

  group('[PostModel]', () {
    test('converts from json correctly', () {
      final postModelFromJson = PostModel.fromJson(postModelJson);

      // Need to match properties rather than instances.
      expect(postModel.userID, postModelFromJson.userID);
      expect(postModel.title, postModelFromJson.title);
      expect(postModel.content, postModelFromJson.content);
      expect(postModel.comments, postModelFromJson.comments);
      expect(postModel.color, postModelFromJson.color);
    });

    test('converts to json correctly', () {
      final postModelToJson = postModel.toJson();

      expect(postModelJson, postModelToJson);
    });

    test("Test if PostModel.copyWith(...) works", () {
      // To test copyWith with default values.
      final copiedSameModel = postModel.copyWith();

      // To test copyWith with different values.
      final newPostModel = postModel.copyWith(
        userID: 'asf1iu3rhfajsf2',
        postID: "gFsuwoh23RfqwAfasRHfuw",
        title: 'second title',
        content: 'second content',
        comments: [],
        color: "#E8F8F5",
      );

      expect(copiedSameModel.userID, postModel.userID);
      expect(copiedSameModel.postID, postModel.postID);
      expect(copiedSameModel.title, postModel.title);
      expect(copiedSameModel.content, postModel.content);
      expect(copiedSameModel.comments, postModel.comments);
      expect(copiedSameModel.color, postModel.color);

      expect(newPostModel.userID, 'asf1iu3rhfajsf2');
      expect(newPostModel.postID, 'gFsuwoh23RfqwAfasRHfuw');
      expect(newPostModel.title, 'second title');
      expect(newPostModel.content, 'second content');
      expect(newPostModel.comments, []);
      expect(newPostModel.color, "#E8F8F5");
    });
  });
}
