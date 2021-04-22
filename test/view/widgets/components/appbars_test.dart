import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget appBarWithLogo;
  Widget defaultAppBar;

  Widget mainWidgetForAppBarWithLogo;
  Widget mainWidgetForDefaultAppBar;

  setUpAll(() {
    appBarWithLogo = AppBarWithLogo();
    defaultAppBar = DefaultAppBar(
      onLeadingTap: () {},
    );

    mainWidgetForAppBarWithLogo = MaterialApp(
      title: "AppBar With Logo",
      home: Scaffold(appBar: appBarWithLogo),
    );

    mainWidgetForDefaultAppBar = MaterialApp(
      title: "Default AppBar",
      home: Scaffold(appBar: defaultAppBar),
    );
  });

  group("[AppBarWithLogo]", () {
    testWidgets('AppBar With Logo Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidgetForAppBarWithLogo);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);

      // AppBarWithLogo tests.
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byKey(Key('anon.logo')), findsOneWidget);
    });
  });

  group("[DefaultAppBar]", () {
    testWidgets('defaultAppBar Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidgetForDefaultAppBar);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);

      // DefaultAppBar tests.
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_outlined), findsOneWidget);

      // Gesture tests.
      await tester.tap(find.byKey(Key("go.back.button")));
    });
  });
}
