import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/components/post_card.dart';

void main() {
  Widget postCardWidget;
  Widget mainWidget;

  PostModel postModel;

  setUpAll(() {
    postModel = PostModel(
      userID: 'empty',
      title: 'Lorem ipsum dolor sit amet ..',
      content: 'More lorem ipsum 123123',
    );

    postCardWidget = PostCardWidget(
      postModel: postModel,
      onTap: () {},
      onViewCommentsTap: () {},
    );

    mainWidget = MaterialApp(
      title: "Post Card Widget",
      home: Scaffold(
        body: postCardWidget,
      ),
    );
  });

  group("[PostCardWidget]", () {
    testWidgets('Post Card test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(PostCardWidget), findsOneWidget);

      // [PostCardWidget] tests.
      expect(find.byType(OpacityButton), findsNWidgets(2));
      expect(find.byType(Stack), findsNWidgets(2));
      expect(find.byType(Container), findsNWidgets(3));
      expect(find.byType(Padding), findsNWidgets(5));
      expect(find.byType(Text), findsNWidgets(4));
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);

      // Gesture test.
      await tester.tap(find.byKey(Key('view.comments.button')));
      await tester.tap(find.byKey(Key('card.button')));
    });
  });
}
