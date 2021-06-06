import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createButton;
  late Widget mainWidget;

  setUpAll(() {
    createButton = CreateButton(onTap: () {});

    mainWidget = MaterialApp(
      title: "Create Button",
      home: Scaffold(body: createButton),
    );
  });

  group("[CreateButton]", () {
    testWidgets('CreateButton Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CreateButton), findsOneWidget);

      // CreateButton tests.
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text("Create"), findsOneWidget);
    });
  });
}
