import 'package:anon/core/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/components/post_card.dart';

void main() {
  Widget postCardWidget;
  Widget secondPostCardWidget;
  Widget mainWidget;

  PostModel postModel;
  PostModel secondPostModel;

  setUpAll(() {
    postModel = PostModel(
      userID: 'empty',
      title: 'Lorem ipsum dolor sit amet ..',
      content: 'More lorem ipsum 123123',
      comments: [CommentModel(title: 'test title')],
    );

    secondPostModel = postModel.copyWith(
      content: 'empty',
      comments: [],
    );

    postCardWidget = PostCardWidget(
      postModel: postModel,
      onTap: () {},
      onViewCommentsTap: () {},
    );

    secondPostCardWidget = PostCardWidget(
      postModel: secondPostModel,
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
      expect(find.text(postModel.comments.length.toString()), findsOneWidget);

      // Gesture test.
      await tester.tap(find.byKey(Key('view.comments.button')));
      await tester.tap(find.byKey(Key('card.button')));
    });

    testWidgets("test conditions of empty values'",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: secondPostCardWidget));

      expect(find.byKey(Key("SizedBox.shrink")), findsOneWidget);
      expect(find.byKey(Key("SizedBox.shrink.2")), findsOneWidget);
      expect(find.text("N"), findsOneWidget);
    });
  });
}
