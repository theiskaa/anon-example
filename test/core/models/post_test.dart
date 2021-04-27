import 'package:anon/core/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  PostModel postModel;
  PostModelEntity postModelEntity;
  List<PostModel> postModelsList;

  const Map<String, String> postModelJson = {
    'userID': 'empty',
    'title': "title",
    'content': "content"
  };

  setUpAll(() {
    postModel = PostModel(
      userID: "empty",
      title: "title",
      content: 'content',
    );

    postModelEntity = postModel.toEntity();

    postModelsList = [
      postModel,
      postModel.copyWith(userID: 'empty1'),
      postModel.copyWith(userID: 'empty2'),
    ];
  });

  group('[PostModel]', () {
    test('converts from json correctly', () {
      final postModelFromJson = PostModel.fromJson(postModelJson);

      // Need to match properties rather than instances.
      expect(postModel.userID, postModelFromJson.userID);
      expect(postModel.title, postModelFromJson.title);
      expect(postModel.content, postModelFromJson.content);
    });

    test('converts to json correctly', () {
      final postModelToJson = postModel.toJson();

      expect(postModelJson, postModelToJson);
    });

    test('get [PostModel] from [PostModelEntity] correctly', () {
      final postModelFromEntity = PostModel.fromEntity(postModelEntity);

      expect(postModel.userID, postModelFromEntity.userID);
      expect(postModel.title, postModelFromEntity.title);
      expect(postModel.content, postModelFromEntity.content);
    });

    test("Test if PostModel.copyWith(...) works", () {
      // To test copyWith with default values.
      final copiedSameModel = postModel.copyWith();

      // To test copyWith with different values.
      final newPostModel = postModel.copyWith(
        userID: 'asf1iu3rhfajsf2',
        title: 'second title',
        content: 'second content',
      );

      expect(copiedSameModel.userID, postModel.userID);
      expect(copiedSameModel.title, postModel.title);
      expect(copiedSameModel.content, postModel.content);

      expect(newPostModel.userID, 'asf1iu3rhfajsf2');
      expect(newPostModel.title, 'second title');
      expect(newPostModel.content, 'second content');
    });

    test("Test if PostModel.encode(...) and PostModel.decode(...) works", () {
      String encodedList = PostModel.encode(postModelsList);
      List<PostModel> decodedString = PostModel.decode(encodedList);

      expect(encodedList, isA<String>());
      expect(decodedString, isA<List<PostModel>>());
    });
  });

  group('[PostModelEntity]', () {
    test('converts from json correctly', () {
      final postModelFromJson = PostModelEntity.fromJson(postModelJson);

      // Need to match properties rather than instances.
      expect(postModel.userID, postModelFromJson.userID);
      expect(postModel.title, postModelFromJson.title);
      expect(postModel.content, postModelFromJson.content);
    });

    test('converts to json correctly', () {
      final postModelEntityToJson = postModelEntity.toJson();

      expect(postModelJson, postModelEntityToJson);
    });

    test("Test if PostModelEntity.copyWith(...) works", () {
      // To test copyWith with default values.
      final copiedSameModel = postModelEntity.copyWith();

      // To test copyWith with different values.
      final newEntity = postModelEntity.copyWith(
        userID: 'asf1iu3rhfajsf2',
        title: 'second title',
        content: 'second content',
      );

      expect(copiedSameModel.userID, postModelEntity.userID);
      expect(copiedSameModel.title, postModelEntity.title);
      expect(copiedSameModel.content, postModelEntity.content);

      expect(newEntity.userID, 'asf1iu3rhfajsf2');
      expect(newEntity.title, 'second title');
      expect(newEntity.content, 'second content');
    });
  });
}
