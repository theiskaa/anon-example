import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget opacityButton;
  Widget mainWidget;

  setUpAll(() {
    // Initilaze opacityButton.
    opacityButton = OpacityButton(
      child: Text("Tap Here!"),
      enableOnLongPress: true,
      opacityValue: .3,
      onTap: () {},
      onLongPress: () {},
    );

    // Initilaze mainWidget.
    mainWidget = MaterialApp(
      title: "Opacity Button",
      home: Scaffold(
        body: Center(child: opacityButton),
      ),
    );
  });

  group("[OpacityButton]", () {
    testWidgets('Opacity Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);

      // OpacityButton tests.
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(Opacity), findsOneWidget);

      // Gesture tests.
      await tester.tap(find.byType(OpacityButton));
      await tester.longPress(find.byType(OpacityButton));
    });
  });
}
