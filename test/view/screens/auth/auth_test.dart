import 'package:anon/view/screens/auth/auth.dart';
import 'package:anon/view/widgets/opacity_animator.dart';
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
      expect(find.byType(AuthScreen), findsOneWidget);

      // Expect custom widgets.
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(OpacityAnimator), findsOneWidget);
      expect(find.byKey(Key('anon.logo')), findsOneWidget);
      expect(find.byKey(Key('auth.button')), findsOneWidget);
      expect(find.text('Join now'), findsOneWidget);
    });
  });
}
