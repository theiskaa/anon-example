import 'package:anon/core/system/anon.dart';
import 'package:anon/view/screens/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anon/core/utils/test_helpers.dart';

void main() {
  Anon anon;

  late TestableWidgetBuilder testableWidgetBuilder;

  setUpAll(() {
    anon = Anon();

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: Splash(),
    );
  });

  group("[Splash Screen]", () {
    Future<void> testStatelessWidgets(WidgetTester tester) async {
      expect(find.byType(Splash), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableWidget,
        testCases: [testStatelessWidgets],
      ),
    );
  });
}
