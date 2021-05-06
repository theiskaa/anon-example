import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  PostModel postModel;
  CommentModel commentModel;
  List<CommentModel> commentModelList;
  // List<PostModel> postModelsList;

  Map<String, dynamic> postModelJson;

  setUpAll(() {
    commentModel = CommentModel(
      title: 'title',
      description: 'description',
    );

    commentModelList = [
      commentModel,
      commentModel.copyWith(title: 'title1'),
      commentModel.copyWith(title: 'title2'),
    ];

    postModel = PostModel(
      userID: "empty",
      title: "title",
      content: 'content',
      comments: commentModelList,
    );

    // postModelsList = [
    //   postModel,
    //   postModel.copyWith(userID: 'empty1'),
    //   postModel.copyWith(userID: 'empty2'),
    // ];

    postModelJson = {
      'userID': 'empty',
      'title': "title",
      'content': "content",
      'comments': commentModelList,
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
        title: 'second title',
        content: 'second content',
        comments: [],
      );

      expect(copiedSameModel.userID, postModel.userID);
      expect(copiedSameModel.title, postModel.title);
      expect(copiedSameModel.content, postModel.content);
      expect(copiedSameModel.comments, postModel.comments);

      expect(newPostModel.userID, 'asf1iu3rhfajsf2');
      expect(newPostModel.title, 'second title');
      expect(newPostModel.content, 'second content');
      expect(newPostModel.comments, []);
    });

    // test("Test if PostModel.encode(...) and PostModel.decode(...) works", () {
    //   String encodedCommentList = CommentModel.encode(commentModelList);
    //   String encodedList = PostModel.encode(postModelsList, encodedCommentList);

    //   // print(encodedList);
    //   List<PostModel> decodedString =
    //       PostModel.decode(encodedList, encodedCommentList);

    //   expect(encodedList, isA<String>());
    //   expect(decodedString, isA<List<PostModel>>());
    // });
  });
}
