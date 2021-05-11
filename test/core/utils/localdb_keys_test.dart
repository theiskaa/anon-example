import 'package:anon/core/utils/localdb_keys.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("[LocalDbKeys]", () {
    test("Test keys", () {
      expect(LocalDbKeys.postsList, "postsList");
      expect(LocalDbKeys.postListLength, "postsListLength");
      expect(LocalDbKeys.savedPosts, "savedPosts");
      expect(LocalDbKeys.savedPostsLength, "savedPostsLength");
    });
  });
}
