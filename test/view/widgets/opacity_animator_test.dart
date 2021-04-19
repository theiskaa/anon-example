import 'package:anon/view/widgets/opacity_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget opacityAnimator;
  Widget mainWidget;

  setUpAll(() {
    opacityAnimator = OpacityAnimator(child: Text(":D"));

    mainWidget = MaterialApp(
      title: "Opacity Animator",
      home: Scaffold(
        body: Center(child: opacityAnimator),
      ),
    );
  });

  group("[OpacityAnimator]", () {
    testWidgets('Opacity Animator Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(OpacityAnimator), findsOneWidget);

      // AuthButton tests.
      expect(find.byKey(Key('opacity.animator')), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
