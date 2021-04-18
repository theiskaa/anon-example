import 'package:anon/view/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widget;

  setUpAll(() {
    widget = MaterialApp(
      title: "Auth Screen",
      home: AuthScreen(),
    );
  });

  group("[Auth Screen]", () {
    testWidgets('Auth Screen Test', (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));

      // Expect custom widgets.
      expect(find.byKey(Key('anon.logo')), findsOneWidget);
      expect(find.byKey(Key('auth.button')), findsOneWidget);
      expect(find.text('Join now'), findsOneWidget);

      // Gesture tests.
      await tester.tap(find.byKey(Key('auth.button')));
    });
  });
}
