import 'package:anon/core/system/anon.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AnonStatelessWidget testStatelessAnon;
  late AnonStatefulWidget testStatefullAnon;
  late AnonStatefulWidget testAnon;

  Anon? anonTest;

  setUpAll(() {
    testStatelessAnon = TestStatelessWidget();
    testStatefullAnon = TestStatefulWidget();
    testAnon = TestAnonState();

    anonTest = Anon();
  });

  group("[Anon Widgets]", () {
    test('Check if anon exists', () async {
      expect(anonTest, testStatelessAnon.anon);
      expect(anonTest, testStatefullAnon.anon);
      expect(anonTest, testAnon.anon);
    });
  });
}
