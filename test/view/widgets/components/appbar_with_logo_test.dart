import 'package:anon/view/widgets/components/appbar_with_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget appBar;
  Widget mainWidget;

  setUpAll(() {
    appBar = AppBarWithLogo();

    mainWidget = MaterialApp(
      title: "App Bar With Logo",
      home: Scaffold(
        appBar: appBar,
      ),
    );
  });

  group("[AppBarWithLogo]", () {
    testWidgets('AppBar With Logo Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);

      // AppBarWithLogo tests.
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byKey(Key('anon.logo')), findsOneWidget);
    });
  });
}
