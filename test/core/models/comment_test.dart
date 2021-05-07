import 'package:anon/core/model/comment.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  CommentModel commentModel;

  const Map<String, String> commentModelJson = {
    'title': 'Test title',
    'date': "Test date"
  };

  setUpAll(() => commentModel = CommentModel(
        title: "Test title",
        date: "Test date",
      ));

  group('[CommentModel]', () {
    test('converts from json correctly', () {
      final commentModelFromJson = CommentModel.fromJson(commentModelJson);

      // Need to match properties rather than instances.
      expect(commentModel.title, commentModelFromJson.title);
      expect(commentModel.date, commentModelFromJson.date);
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
        date: 'New comment date',
      );

      expect(copiedSameModel.title, commentModel.title);
      expect(copiedSameModel.date, commentModel.date);

      expect(newComment.title, 'New comment title');
      expect(newComment.date, 'New comment date');
    });
  });
}
