import 'package:anon/view/widgets/components/auth_button.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget authButton;
  Widget mainWidget;

  setUpAll(() {
    authButton = AuthButton(
      title: 'Join now',
      onTap: () {},
    );

    mainWidget = MaterialApp(
      title: "Auth Button",
      home: Scaffold(
        body: Center(child: authButton),
      ),
    );
  });

  group("[AuthButton]", () {
    testWidgets('Auth Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));

      // AuthButton tests.
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);

      // Gesture tests.
      await tester.tap(find.byType(AuthButton));
    });
  });
}
