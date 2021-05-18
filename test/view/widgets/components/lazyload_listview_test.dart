import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/components/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/view/widgets/components/lazyload_listview.dart';

void main() {
  Anon anon;

  TestableWidgetBuilder testableWidgetBuilder;

  List<PostModel> postsList;

  setUpAll(() async {
    anon = Anon();

    postsList = List.generate(
      30,
      (i) => PostModel(
        userID: "UID $i",
        title: "Title $i",
        content: "Content $i",
        comments: [CommentModel(title: 'test title')],
        color: "#FEF9E7",
      ),
    );

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: false,
      anon: anon,
      widget: LazyLoadListView(defaultList: postsList),
    );
  });

  group("[LazyLoadListView]", () {
    Future<void> testLoadedList(WidgetTester tester) async {
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(PostCardWidget), findsNWidgets(7));
      expect(find.byType(Padding), findsNWidgets(14));
      expect(find.byType(Center), findsNWidgets(14));
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableWidget,
        testCases: [testLoadedList],
      ),
    );
  });
}
