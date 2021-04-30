import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/view_post.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';

void main() {
  Anon anon;
  PostModel postModel;

  TestableWidgetBuilder testableWidgetBuilder;

  setUpAll(() {
    anon = Anon();

    postModel = PostModel(
      userID: 'test id',
      title: "Title of Post",
      content: 'Des of post',
    );

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: ViewPost(postModel: postModel),
    );
  });

  group("[ViewPost]", () {
    Future<void> testViewPostPage(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(Text), findsOneWidget);
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableWidget,
        testCases: [testViewPostPage],
      ),
    );
  });
}
