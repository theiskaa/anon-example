import 'package:anon/view/screens/pages/main_page.dart';
import 'package:anon/view/widgets/components/appbar_with_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widget;

  setUpAll(() {
    widget = MaterialApp(
      title: "Main Page",
      home: MainPage(),
    );
  });

  group("[Main Page]", () {
    testWidgets('Auth Screen Test', (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MainPage), findsOneWidget);

      // Expect custom widgets.
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(Padding), findsNWidgets(2));
      expect(find.byKey(Key('logout.button')), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text("Nothin' for now :)"), findsOneWidget);
    });
  });
}
