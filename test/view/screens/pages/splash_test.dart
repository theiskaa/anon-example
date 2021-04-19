import 'package:anon/view/screens/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widget;

  setUpAll(() {
    widget = MaterialApp(
      title: "Splash",
      home: Splash(),
    );
  });

  group("[Splash Screen]", () {
    testWidgets('Auth Screen Test', (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Splash), findsOneWidget);

      // Expect custom widgets.
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
