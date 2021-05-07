import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/view/widgets/components/animated_add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Anon anon;

  TestableWidgetBuilder builderOfAnimatedAddButton;

  setUpAll(() {
    anon = Anon();

    builderOfAnimatedAddButton = TestableWidgetBuilder(
      anon: anon,
      widget: AnimatedAddButton(
        onTap: () {},
        key: Key("button"),
      ),
    );
  });

  // Main group consisting of all things related to [AnimatedAddButton] Widget.
  group('[AnimatedAddButton]', () {
    Future<void> testInitialWidgets(WidgetTester tester) async {
      expect(find.byType(AnimatedBuilder), findsNWidgets(5));
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byIcon(CupertinoIcons.arrow_up_circle), findsOneWidget);
    }

    /// Builds the [AnimatedAddButton] Widget and runs it through
    /// the [testInitialWidgets] function.
    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: builderOfAnimatedAddButton.buildTestableWidget,
        containsAnimations: true,
        testCases: [testInitialWidgets],
        postProcess: () async => await tester.tap(find.byKey(Key("button"))),
      ),
    );
  });
}
