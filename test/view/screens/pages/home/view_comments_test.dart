import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/view_comments.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';

void main() {
  Anon anon;
  PostModel postModel;
  PostModel postModelWithNoComments;

  TestableWidgetBuilder testableWidgetBuilder;

  MockNavigatorObserver mockObserver;

  setUpAll(() {
    anon = Anon();

    postModel = PostModel(
      userID: 'test id',
      title: "Title of Post",
      content: 'Des of post',
      comments: [CommentModel(title: "test title").toJson()],
    );

    postModelWithNoComments = postModel.copyWith(comments: []);

    mockObserver = MockNavigatorObserver();

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      navigatorObservers: [mockObserver],
      widget: ViewComments(post: postModel),
    );
  });

  group("[ViewComments]", () {
    Future<void> testViewComments(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(ListTile), findsOneWidget);
      expect(
        find.byIcon(CupertinoIcons.arrowshape_turn_up_right_fill),
        findsOneWidget,
      );
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableWidget,
        testCases: [testViewComments],
      ),
    );

    testWidgets(
      "Empty comments screen test",
      (WidgetTester tester) async => {
        await tester.pumpWidget(MaterialApp(
          home: ViewComments(post: postModelWithNoComments),
        )),
        expect(find.byType(Center), findsNWidgets(2)),
        expect(find.byType(Text), findsNWidgets(2)),
        expect(
          find.text("This post hasn't any comment, let's add first!"),
          findsOneWidget,
        )
      },
    );
  });
}
