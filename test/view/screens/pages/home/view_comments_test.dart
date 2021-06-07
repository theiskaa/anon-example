import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/view_comments.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';

void main() {
  Anon anon;
  PostModel postModel;
  PostModel postModelWithNoComments;

  late TestableWidgetBuilder testableWidgetBuilder;
  late TestableWidgetBuilder secondTestableWidgetBuilder;

  setUpAll(() {
    anon = Anon();

    postModel = PostModel(
      userID: 'test id',
      title: "Title of Post",
      content: 'Des of post',
      comments: [CommentModel(title: "test title").toJson()],
    );

    postModelWithNoComments = postModel.copyWith(comments: []);

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (context) => UserserviceBloc()),
      ],
      widget: ViewComments(post: postModel),
    );

    secondTestableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (context) => UserserviceBloc()),
      ],
      widget: ViewComments(post: postModelWithNoComments),
    );
  });

  group("[ViewComments]", () {
    Future<void> testViewComments(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Padding), findsNWidgets(13));
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byType(Container), findsNWidgets(4));
      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(
        find.byIcon(CupertinoIcons.arrowshape_turn_up_right_fill),
        findsOneWidget,
      );
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        testCases: [testViewComments],
      ),
    );

    Future<void> testNoCommentsWidget(WidgetTester tester) async {
      expect(find.byType(Center), findsNWidgets(5));
      expect(find.byType(Text), findsNWidgets(3));
      expect(
        find.text("This post hasn't any comment"),
        findsOneWidget,
      );
    }

    testWidgets(
      "Empty comments screen test",
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: secondTestableWidgetBuilder.buildTestableStateWidget,
        testCases: [testNoCommentsWidget],
      ),
    );
  });
}
