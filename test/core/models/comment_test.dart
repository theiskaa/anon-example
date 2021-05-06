import 'package:anon/core/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  CommentModel commentModel;

  const Map<String, String> commentModelJson = {
    'title': 'Test title',
    'description': "Test description"
  };

  setUpAll(() => commentModel = CommentModel(
        title: "Test title",
        description: "Test description",
      ));

  group('[CommentModel]', () {
    test('converts from json correctly', () {
      final commentModelFromJson = CommentModel.fromJson(commentModelJson);

      // Need to match properties rather than instances.
      expect(commentModel.title, commentModelFromJson.title);
      expect(commentModel.description, commentModelFromJson.description);
    });

    test('converts to json correctly', () {
      final commentModelToJson = commentModel.toJson();

      expect(commentModelJson, commentModelToJson);
    });

    test("Test if CommentModel.copyWith(...) works", () {
      // To test copyWith with default values.
      final copiedSameModel = commentModel.copyWith();

      // To test copyWith with different values.
      final newComment = commentModel.copyWith(
        title: 'New comment title',
        description: 'New comment description',
      );

      expect(copiedSameModel.title, commentModel.title);
      expect(copiedSameModel.description, commentModel.description);

      expect(newComment.title, 'New comment title');
      expect(newComment.description, 'New comment description');
    });
  });
}
