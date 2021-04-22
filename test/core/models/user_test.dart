import 'package:anon/core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  UserModel userModel;
  const Map<String, String> userModelJson = {'id': 'empty'};

  setUpAll(() => userModel = UserModel(id: 'empty'));

  group('[UserModel]', () {
    test('converts from json correctly', () {
      final userModelFromJson = UserModel.fromJson(userModelJson);

      // Need to match properties rather than instances.
      expect(userModel.id, userModelFromJson.id);
    });

    test('converts to json correctly', () {
      final userModelToJson = userModel.toJson();

      expect(userModelJson, userModelToJson);
    });

    test('empty userModel', () {
      final emptyUser = UserModel.empty;

      expect(emptyUser.id, '');
      expect(emptyUser != userModel, true);
    });
  });
}
