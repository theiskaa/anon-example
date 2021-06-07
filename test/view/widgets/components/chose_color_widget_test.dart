import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/view/widgets/components/chose_color_widget.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/opacity_animator.dart';
import 'package:flutter/material.dart';

void main() {
  Anon anon;

  Widget chooseColorCard;
  late TestableWidgetBuilder testableWidgetBuilder;

  const colors = ["#F5EEF8", "#E8F8F5", "#EBF5FB", "#FEF9E7", "#FDFEFE"];

  setUpAll(() {
    anon = Anon();

    chooseColorCard = ChooseColorCard(
      postColors: colors,
      onSelected: (value) {},
      onUnselected: () {},
    );

    testableWidgetBuilder = TestableWidgetBuilder(
      anon: anon,
      widget: chooseColorCard,
    );
  });

  group("[ChooseColorCard]", () {
    Future<void> testInitialStatesAndWidgets(WidgetTester tester) async {
      expect(find.byType(AnimatedContainer), findsOneWidget);
      expect(find.byType(OpacityAnimator), findsOneWidget);
      expect(find.byType(OpacityButton), findsNWidgets(5));
      expect(find.byType(Row), findsOneWidget);
    }

    testWidgets(
      "should contain initial states and widgets",
      (WidgetTester tester) => asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableWidget,
        testCases: [testInitialStatesAndWidgets],
        postProcess: () async {
          final purpleColorsButton = find.byKey(Key("color-#F5EEF8"));
          final unselectButton = find.byKey(Key("unselect.button"));

          await tester.tap(purpleColorsButton);
          await tester.pumpAndSettle();

          expect(find.byType(OpacityAnimator), findsOneWidget);
          expect(find.byType(OpacityButton), findsOneWidget);
          expect(find.byType(SizedBox), findsNWidgets(2));
          expect(find.byType(Text), findsOneWidget);
          expect(find.byType(Row), findsOneWidget);
          expect(find.text("Purple"), findsOneWidget);

          await tester.tap(unselectButton);
        },
      ),
    );
  });
}
