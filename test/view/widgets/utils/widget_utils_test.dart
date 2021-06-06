import 'package:anon/view/widgets/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Widget mainWidget;

  setUpAll(() {
    mainWidget = MaterialApp(
      title: "Widget Utils ",
      home: Scaffold(
        body: Center(child: divider),
      ),
    );
  });

  group("[Widget Utils]", () {
    testWidgets('`divider`', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(Divider), findsOneWidget);
    });
  });
}
