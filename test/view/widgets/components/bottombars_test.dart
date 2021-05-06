import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anon/view/widgets/components/bottombars.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';

void main() {
  Widget viewCommentsBar;

  Widget mainWidget;

  setUpAll(() {
    viewCommentsBar = ViewCommentsBar(
      commentsLength: 2,
      onTap: () {},
    );

    mainWidget = MaterialApp(
      title: "View comments bar",
      home: Scaffold(bottomNavigationBar: viewCommentsBar),
    );
  });
  group("[ViewCommentsBar]", () {
    testWidgets('initial widgets', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(ViewCommentsBar), findsOneWidget);

      // DefaultAppBar tests.
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);

      // Gesture tests.
      await tester.tap(find.byKey(Key("view.comments.bar")));
    });
  });
}
