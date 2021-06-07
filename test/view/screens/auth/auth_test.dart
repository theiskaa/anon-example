import 'package:anon/core/system/anon.dart';
import 'package:anon/view/screens/auth/auth.dart';
import 'package:anon/view/widgets/opacity_animator.dart';
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
      widget: AuthScreen(),
    );
  });

  group("[Auth Screen]", () {
    Future<void> testStatelessWidgets(WidgetTester tester) async {
      expect(find.byType(AuthScreen), findsOneWidget);

      // Expect custom widgets.
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(OpacityAnimator), findsOneWidget);
      expect(find.byKey(Key('anon.logo')), findsOneWidget);
      expect(find.byKey(Key('auth.button')), findsOneWidget);
      expect(find.text('Join now'), findsOneWidget);
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
