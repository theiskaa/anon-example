import 'package:anon/core/utils/localdb_keys.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("[LocalDbKeys]", () {
    test("Test [postsList]", () {
      final postsList = LocalDbKeys.postsList;
      expect(postsList, LocalDbKeys.postsList);
      expect(postsList, "postsList");
    });
  });
}
