import 'package:anon/view/widgets/components/comment_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anon/view/widgets/components/opacity_button.dart';

void main() {
  Widget commentField;

  Widget mainWidget;
  TextEditingController textEditingController;

  setUpAll(() {
    textEditingController = TextEditingController();

    commentField = CommentField(
      controller: textEditingController,
      onSend: () {},
    );

    mainWidget = MaterialApp(
      title: "Comment field",
      home: Scaffold(bottomNavigationBar: commentField),
    );
  });

  group("[CommentField]", () {
    testWidgets('initial widgets', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CommentField), findsOneWidget);

      // CommentField tests.
      expect(find.byType(Transform), findsNWidgets(3));
      expect(find.byType(Container), findsNWidgets(2));
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(Row), findsNWidgets(2));
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(Expanded), findsNWidgets(2));
      expect(find.byType(CupertinoTextField), findsOneWidget);

      // Gesture / Field tests.
      await tester.tap(find.byKey(Key("send.button")));

      await tester.enterText(find.byKey(Key("comment.field")), "Test comment");

      await tester.pumpAndSettle();
    });
  });
}
